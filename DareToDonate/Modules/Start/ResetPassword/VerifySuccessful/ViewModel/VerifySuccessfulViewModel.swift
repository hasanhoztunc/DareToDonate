//
//  VerifySuccessfulViewModel.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 24.02.2021.
//
import RxSwift
import RxCocoa

protocol VerifySuccessfulViewPresentable {
    
    typealias Input = (
        finish: ControlEvent<()>, ()
    )
    typealias Output = ()
    typealias ViewModelBuilder = (VerifySuccessfulViewPresentable.Input) -> VerifySuccessfulViewPresentable
    
    var input: VerifySuccessfulViewPresentable.Input { get }
    var output: VerifySuccessfulViewPresentable.Output { get }
}

final class VerifySuccessfulViewModel: VerifySuccessfulViewPresentable {
    
    let input: VerifySuccessfulViewPresentable.Input
    let output: VerifySuccessfulViewPresentable.Output
    
    private let bag = DisposeBag()
    
    private typealias RoutingAction = (finishRelay: PublishRelay<()>, ())
    private let routingAction: RoutingAction = (finishRelay: PublishRelay(), ())
    
    typealias Routing = (finish: Driver<()>, ())
    lazy var routing: Routing = (finish: routingAction.finishRelay.asDriver(onErrorDriveWith: .empty()), ())
    
    init(input: VerifySuccessfulViewPresentable.Input) {
        self.input = input
        self.output = VerifySuccessfulViewModel.output()
        
        process()
    }
}

private extension VerifySuccessfulViewModel {
    
    static func output() -> VerifySuccessfulViewPresentable.Output {
        return ()
    }
    
    func process() {
        input.finish
            .map({ [routingAction] in
                routingAction.finishRelay.accept($0)
            })
            .asObservable()
            .subscribe()
            .disposed(by: bag)
    }
}
