//
//  GFEmptyStateView.swift
//  GHFollowers
//
//  Created by Muhammed Emin Bardakcı on 17.02.2023.
//

import UIKit

class GFEmptyStateView: UIView {
    
    let messaLabel = GFTitleLabel(textAlign: .center, fontSize: 28, text: "This user does not have any followers.")
    let logoImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String) {
        super.init(frame: .zero)
        self.messaLabel.text = message
        configure()
    }
    
    private func configure() {
        addSubview(messaLabel)
        addSubview(logoImageView)
        
        messaLabel.numberOfLines = 3
        messaLabel.textColor = .secondaryLabel
        
        logoImageView.image = UIImage(named: "empty-state-logo")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messaLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            messaLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messaLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messaLabel.heightAnchor.constraint(equalToConstant: 200),
            
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3), // ekranın 1.3 katı kalınlığında olacak ve her telefon için değişik büyüklükte olacak
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3), // bunuda width yaptık çünkü kare olmasını istiyoruz
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: 40)
        ])
        
    }
}
