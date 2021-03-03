//
//  VerifyViewModel.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 23.02.2021.
//
import RxSwift
import RxCocoa

protocol VerifyViewPresentable {
    
    typealias Input = (
        digit1: Driver<String>,
        digit2: Driver<String>,
        digit3: Driver<String>,
        digit4: Driver<String>,
        verify: ControlEvent<()>
    )
    typealias Output = ()
    typealias ViewModelBuilder = (VerifyViewPresentable.Input) -> VerifyViewPresentable
    
    var input: VerifyViewPresentable.Input { get }
    var output: VerifyViewPresentable.Output { get }
}

final class VerifyViewModel: VerifyViewPresentable {
    
    let input: VerifyViewPresentable.Input
    let output: VerifyViewPresentable.Output
    
    private let bag = DisposeBag()
    
    private typealias RoutingAction = (verifyRelay: PublishRelay<()>, ())
    private let routingAction: RoutingAction = (verifyRelay: PublishRelay(), ())
    
    typealias Routing = (verify: Driver<()>, ())
    lazy var routing: Routing = (verify: routingAction.verifyRelay.asDriver(onErrorDriveWith: .empty()), ())
    
    init(input: VerifyViewPresentable.Input) {
        self.input = input
        self.output = VerifyViewModel.output()
    
        process()
    }
}

private extension VerifyViewModel {
    
    static func output() -> VerifyViewPresentable.Output {
        return ()
    }
    
    func process() {
        
        input.verify
            .map({ [routingAction] in
                routingAction.verifyRelay.accept($0)
            })
            .asObservable()
            .subscribe()
            .disposed(by: bag)
    }
}
