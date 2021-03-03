//
//  OnbooardingSecondViewModel.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 22.02.2021.
//

import RxSwift
import RxCocoa

protocol OnboardingSecondViewPresentable {
    
    typealias Input = (
        skip: ControlEvent<()>,
        next: ControlEvent<()>
    )
    typealias Output = ()
    typealias ViewModelBuilder = (OnboardingSecondViewPresentable.Input) -> OnboardingSecondViewPresentable
    
    var input: OnboardingSecondViewPresentable.Input { get }
    var output: OnboardingSecondViewPresentable.Output { get }
}

final class OnboardingSecondViewModel: OnboardingSecondViewPresentable {
    
    let input: OnboardingSecondViewPresentable.Input
    let output: OnboardingSecondViewPresentable.Output
    
    private let bag = DisposeBag()
    
    private typealias RoutingAction = (skipRelay: PublishRelay<()>, nextRelay: PublishRelay<()>)
    private let routingAction: RoutingAction = (skipRelay: PublishRelay(), nextRelay: PublishRelay())
    
    typealias Routing = (skip: Driver<()>, next: Driver<()>)
    lazy var routing: Routing = (
        skip: routingAction.skipRelay.asDriver(onErrorDriveWith: .empty()),
        next: routingAction.nextRelay.asDriver(onErrorDriveWith: .empty())
    )
    
    init(input: OnboardingSecondViewPresentable.Input) {
        self.input = input
        self.output = OnboardingSecondViewModel.output()
        
        self.process()
    }
}

private extension OnboardingSecondViewModel {
    
    static func output() -> OnboardingSecondViewPresentable.Output {
        return ()
    }
    
    func process() {
        input.next
            .map({ [routingAction] in
                routingAction.nextRelay.accept($0)
            })
            .asDriver(onErrorDriveWith: .empty())
            .drive()
            .disposed(by: bag)
        
        input.skip
            .map({ [routingAction] in
                routingAction.skipRelay.accept($0)
            })
            .asDriver(onErrorDriveWith: .empty())
            .drive()
            .disposed(by: bag)
    }
}
