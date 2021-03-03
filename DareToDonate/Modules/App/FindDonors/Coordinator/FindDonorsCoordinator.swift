//
//  FindDonorsCoordinator.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 26.02.2021.
//

import UIKit

final class FindDonorsCoordinator: BaseCoordinator {
    
    private let router: Routing
    
    init(router: Routing) {
        self.router = router
    }
    
    override func start() {
        let view = FindDonorsViewController.instantiate(from: "FindDonors")
        
        view.viewModelBuilder = {
            FindDonorsViewModel(input: $0, dependencies: (
                title: "Find Donors", ()
            ))
        }
        
        router.push(view, isAnimated: true, onNavigationBack: isCompleted)
    }
}
