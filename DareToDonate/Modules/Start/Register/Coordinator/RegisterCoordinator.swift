//
//  RegisterCoordinator.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 23.02.2021.
//

import UIKit
import RxSwift

final class RegisterCoordinator: BaseCoordinator {
    
    private let router: Routing
    
    private let bag = DisposeBag()
    
    init(router: Routing) {
        self.router = router
    }
    
    override func start() {
        
        let view = RegisterViewController.instantiate(from: "Register")
        
        view.viewModelBuilder = { [bag] in
            let viewModel = RegisterViewModel(input: $0)
        
            viewModel.routing
                .register
                .map({ [weak self] in
                    guard let self = self else { return }
                    self.register()
                })
                .drive()
                .disposed(by: bag)
            
            viewModel.routing
                .logIn
                .map({ [weak self] in
                    guard let self = self else { return }
                    self.login()
                })
                .drive()
                .disposed(by: bag)
            
            return viewModel
        }
        
        router.push(view, isAnimated: true, onNavigationBack: isCompleted)
    }
}

private extension RegisterCoordinator {
    
    func register() {
        print("Register")
    }
    
    func login() {
        router.pop(true)
    }
}
