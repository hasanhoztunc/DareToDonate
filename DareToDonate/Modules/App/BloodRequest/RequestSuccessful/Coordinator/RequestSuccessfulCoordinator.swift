//
//  RequestSuccessfulCoordinator.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 1.03.2021.
//

import UIKit

final class RequestSuccessfulCoordinator: BaseCoordinator {
    
    private let router: Routing
        
    init(router: Routing) {
        self.router = router
    }
    
    override func start() {
        let view = RequestSuccessfulViewController.instantiate(from: "RequestSuccessful")
        
        view.viewModelBuilder = {
            RequestSuccessfulViewModel(input: $0)
        }
        
        router.present(view, isAnimated: true, onDismiss: isCompleted)
    }
}
