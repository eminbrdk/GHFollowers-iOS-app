//
//  FavoriteCell.swift
//  GHFollowers
//
//  Created by Muhammed Emin Bardakcı on 23.02.2023.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    static let reuseID = "FavoriteCell"
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let avatarTitleLable = GFTitleLabel(textAlign: .left, fontSize: 26, text: "alsmdaasd")
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(favorite: Follower) {
        self.avatarTitleLable.text = favorite.login
        avatarImageView.downloadImage(from: favorite.avatarUrl)
    }
    
    private func configure() {
        addSubview(avatarImageView)
        addSubview(avatarTitleLable)
        
        accessoryType = .disclosureIndicator
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor),
            
            avatarTitleLable.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarTitleLable.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            avatarTitleLable.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 24),
            avatarTitleLable.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
