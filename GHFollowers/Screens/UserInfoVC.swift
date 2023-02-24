import UIKit


protocol UserInfoVCDelegate {
    func didTapGitHubProfile(user: User)
    func didTapGetFollowers(user: User)
}


class UserInfoVC: UIViewController {
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    var itemViews: [UIView] = []
    let dateLabel = GFBodyLabel(textAlignment: .center, text: "adsşlöalşd")
    
    var userName: String!
    var delegate: FollowerListVCDelagete!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        layoutUI()
        getUserInfo()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: userName) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure(let errorMessage):
                self.presentGFAlertOnMainThread(title: "Opsss", message: errorMessage.rawValue, buttonTitle: "Ok")
                
            case .success(let user):
                DispatchQueue.main.async {
                    self.configureUIElements(user: user)
                }
            }
        }
    }
    
    func configureUIElements(user: User) {
        let repoItemVC = GFItemInfoVCViewController(user: user, type: .one)
        repoItemVC.delegate = self
        
        let followerItemVC = GFItemInfoVCViewController(user: user, type: .two)
        followerItemVC.delegate = self
        
        
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVC: repoItemVC, to: self.itemViewOne)
        self.add(childVC: followerItemVC, to: self.itemViewTwo)
        self.dateLabel.text = "GitHub Since " + user.createdAt.convertToDisplayDormat()
    }
    
    func layoutUI() {
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
        
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}


extension UserInfoVC: UserInfoVCDelegate {
    func didTapGetFollowers(user: User) {
        if user.followers == 0 {
            presentGFAlertOnMainThread(title: "zero follower", message: "bu kullanıcı yalnızlıktan ölecek lan.", buttonTitle: "Ok")
            return
        }
        delegate.didRequestFollowers(userName1: user.login)
        dismissVC()
    }
    
    func didTapGitHubProfile(user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Invalid Url", message: "The url attached to the user is invalid.", buttonTitle: "Ok")
            return
        }
        
        presentSafariVC(url: url)
    }
}
