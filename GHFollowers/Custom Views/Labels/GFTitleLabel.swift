//
//  GFTitleLabel.swift
//  GHFollowers
//
//  Created by Muhammed Emin Bardakcı on 11.02.2023.
//

import UIKit

class GFTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlign: NSTextAlignment, fontSize: CGFloat, text: String) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        self.text = text
        configure()
    }
    
    private func configure() {
        textColor = .label // dark ve light modda değişir (label, system ...)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
