//
//  VerifySuccessfulCoordinator.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 24.02.2021.
//

import UIKit
import RxSwift
import RxCocoa

final class VerifySuccessfulCoordinator: BaseCoordinator {
    
    private let router: Routing
    
    private let bag = DisposeBag()
    
    init(router: Routing) {
        self.router = router
    }
    
    override func start() {
        let view = VerifySuccessfulViewController.instantiate(from: "VerifySuccessful")
        
        view.viewModelBuilder = { [bag] in
            let viewModel = VerifySuccessfulViewModel(input: $0)
            
            viewModel.routing
                .finish
                .map({ [weak self] in
                    guard let self = self else { return }
                    self.finish()
                })
                .drive()
                .disposed(by: bag)
            
            return viewModel
        }
        
        router.push(view, isAnimated: true, onNavigationBack: isCompleted)
    }
}

private extension VerifySuccessfulCoordinator {
    
    func finish() {
        print("finish")
    }
}
