//
//  FollowerCell.swift
//  GHFollowers
//
//  Created by Muhammed Emin Bardakcı on 15.02.2023.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    static let reuseID = "FollowerCell"
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let avatarTitleLable = GFTitleLabel(textAlign: .center, fontSize: 16, text: "alsmdaasd")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower) {
        avatarTitleLable.text = follower.login
        avatarImageView.downloadImage(from: follower.avatarUrl)
    }
    
    private func configure() {
        addSubview(avatarImageView)
        addSubview(avatarTitleLable)
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            avatarTitleLable.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            avatarTitleLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarTitleLable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            avatarTitleLable.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
