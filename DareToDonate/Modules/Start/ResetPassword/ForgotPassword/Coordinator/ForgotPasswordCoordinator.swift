//
//  ForgotPasswordCoordinator.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 23.02.2021.
//

import UIKit
import RxSwift
import RxCocoa

final class ForgotPasswordCoordinator: BaseCoordinator {
    
    private let router: Routing
    
    private let bag = DisposeBag()
    
    init(router: Routing) {
        self.router = router
    }
    
    override func start() {
        let view = ForgotPasswordViewController.instantiate(from: "ForgotPassword")
        
        view.viewModelBuilder = { [bag] in
            let viewModel = ForgotPasswordViewModel(input: $0)
        
            viewModel.routing
                .send
                .map({ [weak self] in
                    guard let self = self else { return }
                    self.verify()
                })
                .drive()
                .disposed(by: bag)
            
            return viewModel
        }
        
        router.push(view, isAnimated: true, onNavigationBack: isCompleted)
    }
}

private extension ForgotPasswordCoordinator {
    
    func verify() {
        let verifyCoordinator = VerifyCoordinator(router: router)
        self.add(coordinator: verifyCoordinator)
        
        verifyCoordinator.isCompleted = { [weak self, weak verifyCoordinator] in
            guard let coordinator = verifyCoordinator,
                  let self = self else { return }
            self.remove(coordinator: coordinator)
        }
        
        verifyCoordinator.start()
    }
}
