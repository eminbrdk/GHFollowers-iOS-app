//
//  GFBodyLabel.swift
//  GHFollowers
//
//  Created by Muhammed Emin Bardakcı on 11.02.2023.
//

import UIKit

class GFBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    init(textAlignment: NSTextAlignment, text: String) {
        super.init(frame: .zero)
        self.text = text
        self.textAlignment = textAlignment
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .label // dark ve light modda değişir (label, system ...)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        font = UIFont.preferredFont(forTextStyle: .body)
        
    }
}
