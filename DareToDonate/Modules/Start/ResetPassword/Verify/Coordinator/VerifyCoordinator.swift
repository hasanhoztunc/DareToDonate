//
//  VerifyCoordinator.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 23.02.2021.
//

import UIKit
import RxSwift
import RxCocoa

final class VerifyCoordinator: BaseCoordinator {
    
    private let router: Routing
    
    private let bag = DisposeBag()
    
    init(router: Routing) {
        self.router = router
    }
    
    override func start() {
        let view = VerifyViewController.instantiate(from: "Verify")
        
        view.viewModelBuilder = { [bag] in
            let viewModel = VerifyViewModel(input: $0)
            
            viewModel.routing
                .verify
                .map({ [weak self] in
                    guard let self = self else { return }
                    self.successfull()
                })
                .drive()
                .disposed(by: bag)
            
            return viewModel
        }
        
        router.push(view, isAnimated: true, onNavigationBack: isCompleted)
    }
}

private extension VerifyCoordinator {
    
    func successfull() {
        let verifySuccessfulCoordinator = VerifySuccessfulCoordinator(router: router)
        self.add(coordinator: verifySuccessfulCoordinator)
        
        verifySuccessfulCoordinator.isCompleted = { [weak self, weak verifySuccessfulCoordinator] in
            guard let coordinator = verifySuccessfulCoordinator,
                  let self = self else { return}
            self.remove(coordinator: coordinator)
        }
        
        verifySuccessfulCoordinator.start()
    }
}
