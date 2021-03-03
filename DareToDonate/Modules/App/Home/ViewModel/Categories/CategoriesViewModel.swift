//
//  CategoriesViewModel.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 25.02.2021.
//
import UIKit

protocol CategoriesViewPresentable {
    
    var title: String { get }
    var image: UIImage { get }
}

struct CategoriesViewModel: CategoriesViewPresentable {
    
    var image: UIImage
    var title: String
}
