//
//  Drawable.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 22.02.2021.
//

import UIKit

protocol Drawable {
    
    var viewController: UIViewController? { get }
}

extension UIViewController: Drawable {
    
    var viewController: UIViewController? {
        self
    }
}
