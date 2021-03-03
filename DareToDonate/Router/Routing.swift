//
//  Routing.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 22.02.2021.
//

typealias NavigationBackClosure = (() -> ())

protocol Routing {
    
    func push(_ drawable: Drawable, isAnimated: Bool, onNavigationBack: NavigationBackClosure?)
    func pop(_ isAnimated: Bool)
    func popToRoot(_ isAnimated: Bool)
    func present(_ drawable: Drawable, isAnimated: Bool, onDismiss: NavigationBackClosure?)
}
