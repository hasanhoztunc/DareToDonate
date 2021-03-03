//
//  ReportCoordinatro.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 1.03.2021.
//

import UIKit

final class ReportCoordinator: BaseCoordinator {
    
    private let router: Routing
    
    init(router: Routing) {
        self.router = router
    }
    
    override func start() {
        let view = ReportViewController.instantiate(from: "Report")
        
        view.viewModelBuilder = {
            ReportViewModel(input: $0, dependencies: (
                title: "Report", ()
            ))
        }
        
        router.push(view, isAnimated: true, onNavigationBack: isCompleted)
    }
}
