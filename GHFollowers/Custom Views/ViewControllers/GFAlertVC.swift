//
//  GFAlertVC.swift
//  GHFollowers
//
//  Created by Muhammed Emin Bardakcı on 11.02.2023.
//

import UIKit

class GFAlertVC: UIViewController {

    let containervView = UIView()
    let titleLabel = GFTitleLabel(textAlign: .center, fontSize: 20, text: "aaaaa")
    let messageLabel = GFBodyLabel(textAlignment: .center, text: "bbbb")
    let actionBUtton = GFButton(backgroundColor: .systemPink, text: "Ok")
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    let padding: CGFloat = 20
    
    init(alertTitle: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.alertTitle = alertTitle
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()
    }
    
    func configureContainerView() {
        view.addSubview(containervView)
        
        containervView.layer.cornerRadius = 16
        containervView.layer.borderWidth = 2
        containervView.layer.borderColor = UIColor.white.cgColor
        containervView.translatesAutoresizingMaskIntoConstraints = false
        containervView.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            containervView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containervView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containervView.heightAnchor.constraint(equalToConstant: 220),
            containervView.widthAnchor.constraint(equalToConstant: 280)
        ])
    }
    
    func configureTitleLabel() {
        containervView.addSubview(titleLabel)
        
        titleLabel.text = alertTitle ?? "Sommething went wrong"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containervView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containervView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containervView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func configureActionButton() {
        containervView.addSubview(actionBUtton)
        
        actionBUtton.setTitle(buttonTitle ?? "Ok", for: .normal)
        
        actionBUtton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionBUtton.bottomAnchor.constraint(equalTo: containervView.bottomAnchor, constant: -padding),
            actionBUtton.leadingAnchor.constraint(equalTo: containervView.leadingAnchor, constant: padding),
            actionBUtton.trailingAnchor.constraint(equalTo: containervView.trailingAnchor, constant: -padding),
            actionBUtton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func configureMessageLabel() {
        containervView.addSubview(messageLabel)
        messageLabel.text = message ?? "Unable to complete request"
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containervView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containervView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: actionBUtton.topAnchor, constant: -12)
            
        ])
        
        
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    

}
