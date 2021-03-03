//
//  CreateRequestCoordinator.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 1.03.2021.
//

import UIKit
import RxSwift
import RxCocoa

final class CreateRequestCoordinator: BaseCoordinator {
    
    private let router: Routing
    private let bag = DisposeBag()
    
    init(router: Routing) {
        self.router = router
    }
    
    override func start() {
        let view = CreateRequestViewController.instantiate(from: "CreateRequest")
        
        view.viewModelBuilder = { [bag] in
            let viewModel = CreateRequestViewModel(input: $0, dependencies: (
                title: "Create A Request", ()
            ))
            
            viewModel.routing
                .route
                .map({ [weak self] in
                    self?.showRequestSuccessful()
                })
                .drive()
                .disposed(by: bag)
            
            return viewModel
        }
        
        router.push(view, isAnimated: true, onNavigationBack: isCompleted)
    }
}

private extension CreateRequestCoordinator {
    
    func showRequestSuccessful() {
        let requestSuccessfulCoordinator = RequestSuccessfulCoordinator(router: router)
        self.add(coordinator: requestSuccessfulCoordinator)
        
        requestSuccessfulCoordinator.isCompleted = { [weak self, weak requestSuccessfulCoordinator] in
            guard let coordinator = requestSuccessfulCoordinator,
                  let self = self else { return }
            self.remove(coordinator: coordinator)
        }
        
        requestSuccessfulCoordinator.start()
    }
}
