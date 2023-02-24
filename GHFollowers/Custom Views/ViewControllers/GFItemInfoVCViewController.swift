import UIKit

enum ItemType {
    case one, two
}

class GFItemInfoVCViewController: UIViewController {

    var stackView = UIStackView()
    var userInfoOne = GFItemInfoView()
    var userInfoTwo = GFItemInfoView()
    var infoButton = GFButton()
    
    var user: User!
    var type: ItemType!
    var delegate: UserInfoVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBackgroundViews()
        layoutUI()
        configureStackView()
        setItems()
        configureActionButton()
    }
    
    init(user: User, type: ItemType) {
        super.init(nibName: nil, bundle: nil)
        
        self.user = user
        self.type = type
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func actionButtonTapped() {
        switch type {
        case.one:
            delegate.didTapGitHubProfile(user: user)
        case .two:
            delegate.didTapGetFollowers(user: user)
        case .none:
            return
        }
    }
    
    func setItems() {
        switch type {
        case .one:
            userInfoOne.set(itemInfnoType: .repos, count: user.publicRepos)
            userInfoTwo.set(itemInfnoType: .gists, count: user.publicGists)
            infoButton.setTitle("GitHub Profile", for: .normal)
            infoButton.backgroundColor = .systemPurple
            
        case .two:
            userInfoOne.set(itemInfnoType: .following, count: user.following)
            userInfoTwo.set(itemInfnoType: .followers, count: user.followers)
            infoButton.setTitle("Get Followers", for: .normal)
            infoButton.backgroundColor = .systemGreen
            
        case .none:
            return
        }
    }
    
    func configureBackgroundViews() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(userInfoOne)
        stackView.addArrangedSubview(userInfoTwo)
    }
    
    private func configureActionButton() {
        infoButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    private func layoutUI() {
        view.addSubview(stackView)
        view.addSubview(infoButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            infoButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            infoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            infoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            infoButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    
}
