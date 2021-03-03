//
//  OnboardingSecondCoordinator.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 22.02.2021.
//

import RxCocoa
import RxSwift

final class OnboardingSecondCoordinator: BaseCoordinator {
    
    private let router: Routing
    private let bag = DisposeBag()
    
    init(router: Routing) {
        self.router = router
    }
    
    override func start() {
        let view = OnboardingSecondViewController.instantiate(from: "OnboardingSecond")
        
        view.viewModelBuilder = { [bag] in
            let viewModel = OnboardingSecondViewModel(input: $0)
        
            viewModel.routing
                .next
                .map({ [weak self] in
                    guard let self = self else { return }
                    self.showMembershipTypeSelection()
                })
                .drive()
                .disposed(by: bag)
            
            viewModel.routing
                .skip
                .map({ [weak self] in
                    guard let self = self else { return }
                    self.showMembershipTypeSelection()
                })
                .drive()
                .disposed(by: bag)
            
            return viewModel
        }
        
        router.push(view, isAnimated: true, onNavigationBack: isCompleted)
    }
}

private extension OnboardingSecondCoordinator {
    
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
