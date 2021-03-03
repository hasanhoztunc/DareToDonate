//
//  OnboardingFirstViewModel.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 22.02.2021.
//
import RxSwift
import RxCocoa

protocol OnboardingFirstPresentable {
    
    typealias Input = (
        skip: ControlEvent<()>,
        next: ControlEvent<()>
    )
    typealias Output = ()
    typealias ViewModelBuilder = (OnboardingFirstPresentable.Input) -> OnboardingFirstPresentable
    
    var input: OnboardingFirstPresentable.Input { get }
    var output: OnboardingFirstPresentable.Output { get }
}

final class OnboardingFirstViewModel: OnboardingFirstPresentable {
    
    let input: OnboardingFirstPresentable.Input
    let output: OnboardingFirstPresentable.Output
    
    private let bag = DisposeBag()
    
    private typealias RoutingAction = (skipRelay: PublishRelay<()>, nextRelay: PublishRelay<()>)
    private let routingAction: RoutingAction = (skipRelay: PublishRelay(), nextRelay: PublishRelay())
    
    typealias Routing = (skip: Driver<()>, next: Driver<()>)
    lazy var routing: Routing = (
        skip: routingAction.skipRelay.asDriver(onErrorDriveWith: .empty()),
        next: routingAction.nextRelay.asDriver(onErrorDriveWith: .empty())
    )
    
    init(input: OnboardingFirstPresentable.Input) {
        self.input = input
        self.output = OnboardingFirstViewModel.output()
        process()
    }
}

private extension OnboardingFirstViewModel {
    
    static func output() -> OnboardingFirstPresentable.Output {
        return ()
    }
    
    func process() {
        input.skip
            .map({ [routingAction] in
                routingAction.skipRelay.accept($0)
            })
            .asDriver(onErrorDriveWith: .empty())
            .drive()
            .disposed(by: bag)
        
        input.next
            .map({ [routingAction] in
                routingAction.nextRelay.accept($0)
            })
            .asDriver(onErrorDriveWith: .empty())
            .drive()
            .disposed(by: bag)
    }
}
