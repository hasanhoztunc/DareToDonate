//
//  UIRoundedTextField.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 23.02.2021.
//

import UIKit

final class UIRoundedTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCornerRadius()
        setBackground()
        setFont()
        setTextColor()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setCornerRadius()
        setBackground()
        setFont()
        setTextColor()
    }
    
    func setCornerRadius() {
        layer.cornerRadius = 6
    }
    
    func setBackground() {
        backgroundColor = UIColor.textField
    }
    
    func setFont() {
        font = UIFont(name: "Poppins-Regular", size: 18)
    }
    
    func setTextColor() {
        textColor = UIColor.textFieldText
    }
}
