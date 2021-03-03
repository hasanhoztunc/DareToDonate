//
//  LoginCoordinator.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 23.02.2021.
//

import UIKit
import RxSwift
import RxCocoa

final class LoginCoordinator: BaseCoordinator {
    
    private let router: Routing
    
    private let bag = DisposeBag()
    
    init(router: Routing) {
        self.router = router
    }
    
    override func start() {
        let view = LoginViewController.instantiate(from: "Login")
        
        view.viewModelBuilder = { [bag] in
            let viewModel = LoginViewModel(input: $0)
        
            viewModel.routing
                .login
                .map({ [weak self] in
                    guard let self = self else { return }
                    self.login()
                })
                .drive()
                .disposed(by: bag)
            
            viewModel.routing
                .forgotPassword
                .map({ [weak self] in
                    guard let self = self else { return }
                    self.forgotPassword()
                })
                .drive()
                .disposed(by: bag)
            
            viewModel.routing
                .register
                .map({ [weak self] in
                    guard let self = self else { return }
                    self.register()
                })
                .drive()
                .disposed(by: bag)
            
            return viewModel
        }
        
        router.push(view, isAnimated: true, onNavigationBack: isCompleted)
    }
}

private extension LoginCoordinator {
    
    func login() {
        let homeCoordinator = HomeCoordinator(router: router)
        self.add(coordinator: homeCoordinator)
                
        homeCoordinator.isCompleted = { [weak self, weak homeCoordinator] in
            guard let coordinator = homeCoordinator,
                  let self = self else { return }
            self.remove(coordinator: coordinator)
        }
        
        homeCoordinator.start()
    }
    
    func forgotPassword() {
        let forgotPasswordCoordinator = ForgotPasswordCoordinator(router: router)
        self.add(coordinator: forgotPasswordCoordinator)
        
        forgotPasswordCoordinator.isCompleted = { [weak self, weak forgotPasswordCoordinator] in
            guard let coordinator = forgotPasswordCoordinator,
                  let self = self else { return }
            self.remove(coordinator: coordinator)
        }
        
        forgotPasswordCoordinator.start()
    }
    
    func register() {
        router.pop(true)
    }
}
