import UIKit

class SearchVC: UIViewController {
    
    let logoImageView = UIImageView()
    let userNameTextField = GFTextField()
    let callToActionButton = GFButton(backgroundColor: .systemGreen, text: "Get Followers")
    
    var isUserNameEntered: Bool {
        get {
            return !userNameTextField.text!.isEmpty
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground //normalde beyaz, dark modda siyah
        
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createDismissKeyboardTapGesture()
    }
    
    // sadece uygulama açıldığında değil bu sayfaya her geldiğimizde gerçekleşir
    // ne zaman bu sayfaya gelsek çalışır
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // ekrana tıkladığında kılavye gitsin diye ayarladık
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushFollowerListVC() {
        guard isUserNameEntered else {
            presentGFAlertOnMainThread(title: "Empty Username", message: "Please enter a username. We need to know who to look for :)", buttonTitle: "Ok") // NC yok present var
            return
        } // username girilmemişse fonksiyonun devamı gerçekleşmeyecek
        
        let followerListVC = FollowerListVC()
        followerListVC.userName = userNameTextField.text
        followerListVC.title = userNameTextField.text
        navigationController?.pushViewController(followerListVC, animated: true) // NS var ns içinde push var
    }
    
    func configureLogoImageView() {
        view.addSubview(logoImageView) // kütüphaneden storybıarda ekleme yapmak gibi
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTextField() {
        view.addSubview(userNameTextField)
        userNameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50), // sol
            userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50), // sağ
            userNameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureCallToActionButton() {
        view.addSubview(callToActionButton)
        // butona basıldığında gerçekleşecek eylem
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}


extension SearchVC: UITextFieldDelegate {
    
    // entera basıldımı gerçekleşecek
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}
