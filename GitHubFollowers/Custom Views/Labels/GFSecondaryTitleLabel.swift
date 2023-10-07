//
//  GFSecondaryTitleLabel.swift
//  GitHubFollowers
//
//  Created by mohamed ahmed on 02/10/2023.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(fontSize: CGFloat){
        super.init(frame: .zero)
        self.font           = UIFont.systemFont(ofSize: fontSize,weight: .medium)
        configure()
    }
    
    private func configure(){
        textColor                   = .secondaryLabel
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.9
        lineBreakMode               = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints=false
    }

}
