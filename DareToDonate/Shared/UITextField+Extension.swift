//
//  UITextField+Extension.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 23.02.2021.
//

import UIKit

extension UITextField {
    
    func leftIcon(icon name: String) {
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 86.5, height: 65))
        
        let rightLine = UIView(frame: CGRect(x: 70, y: 6, width: 1, height: 53))
        rightLine.backgroundColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1)
        leftView.addSubview(rightLine)
        
        self.leftViewMode = .always
        let imageView = UIImageView(frame: CGRect(x: 26, y: 20, width: 24, height: 24))
        let image = UIImage(named: name)
        imageView.image = image
        
        leftView.addSubview(imageView)
        
        self.leftView = leftView
    }
    
    func leftIcon(icon name: String, size: CGRect) {
        let leftView = UIView(frame: size)
        
        self.leftViewMode = .always
        let imageView = UIImageView(frame: CGRect(x: 36, y: 12, width: 24, height: 24))
        let image = UIImage(named: name)
        imageView.image = image
        imageView.tintColor = UIColor(red: 178/255, green: 178/255, blue: 178/255, alpha: 1)
        
        leftView.addSubview(imageView)
        
        self.leftView = leftView
    }
}
