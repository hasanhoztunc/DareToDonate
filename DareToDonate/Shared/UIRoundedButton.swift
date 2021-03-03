//
//  UIRoundedButton.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 23.02.2021.
//

import UIKit

final class UIRoundedButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCornerRadius()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setCornerRadius()
    }
    
    func setCornerRadius() {
        layer.cornerRadius = frame.size.height / 2
    }
}
