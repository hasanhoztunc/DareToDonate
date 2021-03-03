//
//  DonationRequestCoordinator.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 26.02.2021.
//

import UIKit

final class DonationRequestCoordinator: BaseCoordinator {
    
    private let router: Routing
    
    init(router: Routing) {
        self.router = router
    }
    
    override func start() {
        let view = DonationRequestViewController.instantiate(from: "DonationRequest")
        
        view.viewModelBuilder = {
            DonationRequestViewModel(input: $0, dependencies: (
                title: "Donation Request", ()
            ))
        }
        
        router.push(view, isAnimated: true, onNavigationBack: isCompleted)
    }
}
