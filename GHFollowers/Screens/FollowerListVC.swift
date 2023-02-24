//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Muhammed Emin Bardakcı on 10.02.2023.
//

import UIKit

protocol FollowerListVCDelagete {
    func didRequestFollowers(userName1: String)
}

class FollowerListVC: UIViewController {
    
    enum Section {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    var userName: String!
    var collectionView: UICollectionView!
    
    var followers: [Follower] = []
    var filterArray: [Follower] = []
    
    var page = 1
    var hasMoreFollowers = true
    var areWeInFilter = false // ben
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureSearchController()
        configureCollectionView()
        configureDataSource()
        getFollowers() // önce configure kısımlarını halletmek daha sağlıklı
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(view: view))
        
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    func getFollowers() {
        showLoadingView()
        
        NetworkManager.shared.getFollowers(for: userName, page: page) { [weak self] result in
            guard let self = self else { return }
            
            self.dismissLoadingView()
            
            switch result {
            case .success(let followers):
                self.hasMoreFollowers = !(followers.count < 100)
                self.followers.append(contentsOf: followers)
                
                if self.followers.isEmpty {
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: "bu kullanıcı yalnızlıktan ölecek mk.", in: self.view)
                    }
                    return
                }
                
                self.updateData(on: self.followers)
                
            case .failure(let errorMessage):
                self.presentGFAlertOnMainThread(title: "Bad Struff Happened", message: errorMessage.rawValue, buttonTitle: "Ok")
            }
            
            //guard let followers = result else {
            //    self.presentGFAlertOnMainThread(title: "Bad Struff Happened", message: errorMesage!.rawValue, //buttonTitle: "Ok")
            //    return
            //}
            //
            //print(followers.count)
            //print(followers)
            
        }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
            
        })
    }
    
    func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self // delegate
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController //navigation yerine searchcontroller ekleyebiliyormuşu, ekledik
        
    }
    
    @objc func addButtonTapped() {
        showLoadingView()
        
        NetworkManager.shared.getUserInfo(for: userName) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let user):
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                
                PersistanceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
                    guard let self = self else { return }
                    
                    guard let errorMessage = error else {
                        self.presentGFAlertOnMainThread(title: "Success", message: "You have succesfully favorited this user", buttonTitle: "Ok")
                        return
                    }
                    self.presentGFAlertOnMainThread(title: "opss", message: errorMessage.rawValue, buttonTitle: "OK")
                }
                
            case .failure(let errorMessage):
                self.presentGFAlertOnMainThread(title: "OPSS", message: errorMessage.rawValue, buttonTitle: "Ok")
            }
        }
    }
}


extension FollowerListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y // bulunduğumuz y ekseni
        let contentHeight = scrollView.contentSize.height // gözğken gözükmeyen tüm kaydırma ekranı
        let height = scrollView.frame.size.height // ekranda gözüken kaydırma ekranı
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let follower: Follower = areWeInFilter ? filterArray[indexPath.item] : followers[indexPath.item]
        
        let userInfoVC = UserInfoVC()
        let navController = UINavigationController(rootViewController:  userInfoVC)
        
        userInfoVC.delegate = self
        userInfoVC.title = follower.login
        userInfoVC.userName = follower.login
        
        present(navController, animated: true)
    }
}

extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
    
    // search barda değişiklik olduğunda gerçekleşecek
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            updateData(on: self.followers) // ben
            areWeInFilter = false // ben
            return
        }
        
        areWeInFilter = true // ben
        filterArray = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filterArray)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(on: self.followers)
        areWeInFilter = false // ben
    }
}

extension FollowerListVC: FollowerListVCDelagete {
    func didRequestFollowers(userName1: String) {
        self.page = 1
        self.userName = userName1
        title = userName1
        followers.removeAll()
        filterArray.removeAll() 
        collectionView.setContentOffset(.zero, animated: true)
        getFollowers()
    }
}
