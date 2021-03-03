//
//  ForgotPasswordViewModel.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 23.02.2021.
//
import RxSwift
import RxCocoa

protocol ForgotPasswordViewPresentable {
    
    typealias Input = (
        email: Driver<String>,
        send: ControlEvent<()>
    )
    typealias Output = ()
    typealias ViewModelBuilder = (ForgotPasswordViewPresentable.Input) -> ForgotPasswordViewPresentable
    
    var input: ForgotPasswordViewPresentable.Input { get }
    var output: ForgotPasswordViewPresentable.Output { get }
}

final class ForgotPasswordViewModel: ForgotPasswordViewPresentable {
    
    let input: ForgotPasswordViewPresentable.Input
    let output: ForgotPasswordViewPresentable.Output
    
    private let bag = DisposeBag()
    
    private typealias RoutingAction = (sendRelay: PublishRelay<()>, ())
    private let routingAction: RoutingAction = (sendRelay: PublishRelay(), ())
    
    typealias Routing = (send: Driver<()>, ())
    lazy var routing: Routing = (send: routingAction.sendRelay.asDriver(onErrorDriveWith: .empty()), ())
    
    init(input: ForgotPasswordViewPresentable.Input) {
        self.input = input
        self.output = ForgotPasswordViewModel.output()
        
        process()
    }
}

private extension ForgotPasswordViewModel {
    
    static func output() -> ForgotPasswordViewPresentable.Output {
        return ()
    }

    func process() {
        input.send
            .map({ [routingAction] in
                routingAction.sendRelay.accept($0)
            })
            .asObservable()
            .subscribe()
            .disposed(by: bag)
    }
}
