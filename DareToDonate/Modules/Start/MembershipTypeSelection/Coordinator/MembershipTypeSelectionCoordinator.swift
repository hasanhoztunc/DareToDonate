//
//  MembershipTypeSelectionCoordinator.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 22.02.2021.
//

import UIKit
import RxSwift

final class MembershipTypeSelectionCoordinator: BaseCoordinator {
    
    private let router: Routing
    private let bag = DisposeBag()
    
    init(router: Routing) {
        self.router = router
    }
    
    override func start() {
        let view = MembershipTypeSelectionViewController.instantiate(from: "MembershipTypeSelection")
        
        view.viewModelBuilder = { [bag] in
            let viewModel = MembershipTypeSelectionViewModel(input: $0)
        
            viewModel.routing
                .login
                .map({ [weak self] in
                    guard let self = self else { return }
                    self.showLogin()
                })
                .drive()
                .disposed(by: bag)
            
            viewModel.routing
                .register
                .map({ [weak self] in
                    guard let self = self else { return }
                    self.showRegister()
                })
                .drive()
                .disposed(by: bag)
            
            return viewModel
        }
        
        router.push(view, isAnimated: true, onNavigationBack: isCompleted)
    }
}

private extension MembershipTypeSelectionCoordinator {
    
    func showLogin() {
        
        let loginCoordinator = LoginCoordinator(router: router)
        self.add(coordinator: loginCoordinator)
        
        loginCoordinator.isCompleted = { [weak self, weak loginCoordinator] in
            guard let coordinator = loginCoordinator,
                  let self = self else { return }
            self.remove(coordinator: coordinator)
        }
        
        loginCoordinator.start()
    }
    
    func showRegister() {
        
        let registerCoordinator = RegisterCoordinator(router: router)
        self.add(coordinator: registerCoordinator)
        
        registerCoordinator.isCompleted = { [weak self, weak registerCoordinator] in
            guard let coordinator = registerCoordinator,
                  let self = self else { return }
            self.remove(coordinator: coordinator)
        }
        
        registerCoordinator.start()
    }
}
