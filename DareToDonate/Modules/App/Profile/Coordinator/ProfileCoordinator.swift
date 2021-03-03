//
//  ProfileCoordinator.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 2.03.2021.
//

import UIKit

final class ProfileCoordinator: BaseCoordinator {
    
    private let router: Routing
    
    init(router: Routing) {
        self.router = router
    }
    
    override func start() {
        let view = ProfileViewController.instantiate(from: "Profile")
        
        view.viewModelBuilder = {
            ProfileViewModel(input: $0, dependencies: (
                title: "Profile", ()
            ))
        }
        
        router.push(view, isAnimated: true, onNavigationBack: isCompleted)
    }
}
