//
//  OnboardingFirstCoordinator.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 22.02.2021.
//

import UIKit
import RxSwift

final class OnboardingFirstCoordinator: BaseCoordinator {
    
    private let router: Routing
    private let bag = DisposeBag()
    
    init(router: Routing) {
        self.router = router
    }
    
    override func start() {
        let view = OnboardingFirstViewController.instantiate(from: "OnboardingFirst")
        
        view.viewModelBuilder = { [bag] in
            let viewModel = OnboardingFirstViewModel(input: $0)
            
            viewModel.routing
                .skip
                .map({ [weak self] in
                    guard let self = self else { return }
                    self.showMembershipTypeSelection()
                })
                .drive()
                .disposed(by: bag)
            
            viewModel.routing
                .next
                .map({ [weak self] in
                    guard let self = self else { return }
                    self.showOnboardingSecond()
                })
                .drive()
                .disposed(by: bag)
            
            return viewModel
        }
        
        router.push(view, isAnimated: true, onNavigationBack: isCompleted)
    }
}

private extension OnboardingFirstCoordinator {
    
    func showOnboardingSecond() {
        let secondOnboardingCoordinator = OnboardingSecondCoordinator(router: router)
        self.add(coordinator: secondOnboardingCoordinator)
        
        secondOnboardingCoordinator.isCompleted = { [weak self, weak secondOnboardingCoordinator] in
            guard let coordinaotor = secondOnboardingCoordinator,
                  let self = self else { return }
            self.remove(coordinator: coordinaotor)
        }
        
        secondOnboardingCoordinator.start()
    }
    
    func showMembershipTypeSelection() {
        let membershipTypeSelectionCoordinator = MembershipTypeSelectionCoordinator(router: router)
        self.add(coordinator: membershipTypeSelectionCoordinator)
        
        membershipTypeSelectionCoordinator.isCompleted = { [weak self, weak membershipTypeSelectionCoordinator] in
            guard let coordinator = membershipTypeSelectionCoordinator,
                  let self = self else { return }
            self.remove(coordinator: coordinator)
        }
        
        membershipTypeSelectionCoordinator.start()
    }
}
