//
//  GFButton.swift
//  GHFollowers
//
//  Created by Muhammed Emin Bardakcı on 10.02.2023.
//

import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor: UIColor, text: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(text, for: .normal)
        configure()
    }
    
    private func configure() {
        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false // butonun yeri otomatik belirlenmeyecek, biz yazıcaz
    }
}
