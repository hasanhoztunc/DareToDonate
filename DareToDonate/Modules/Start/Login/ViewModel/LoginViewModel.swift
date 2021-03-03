//
//  LoginViewModel.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 23.02.2021.
//

import RxSwift
import RxCocoa

protocol LoginViewPresentable {
    
    typealias Input = (
        email: Driver<String>,
        password: Driver<String>,
        login: ControlEvent<()>,
        forgotPassword: ControlEvent<()>,
        register: ControlEvent<()>
    )
    typealias Output = ()
    typealias ViewModelBuilder = (LoginViewPresentable.Input) -> LoginViewPresentable
    
    var input: LoginViewPresentable.Input { get }
    var output: LoginViewPresentable.Output { get }
}

final class LoginViewModel: LoginViewPresentable {
    
    let input: LoginViewPresentable.Input
    let output: LoginViewPresentable.Output
    
    private let bag = DisposeBag()
    
    private typealias RoutingAction = (
        loginRelay: PublishRelay<()>,
        forgotPasswordRelay: PublishRelay<()>,
        registerRelay: PublishRelay<()>
    )
    private let routingAction: RoutingAction = (
        loginRelay: PublishRelay(),
        forgotPasswordRelay: PublishRelay(),
        registerRelay: PublishRelay()
    )
    
    typealias Routing = (
        login: Driver<()>,
        forgotPassword: Driver<()>,
        register: Driver<()>
    )
    lazy var routing: Routing = (
        login: routingAction.loginRelay.asDriver(onErrorDriveWith: .empty()),
        forgotPassword: routingAction.forgotPasswordRelay.asDriver(onErrorDriveWith: .empty()),
        register: routingAction.registerRelay.asDriver(onErrorDriveWith: .empty())
    )
    
    init(input: LoginViewPresentable.Input) {
        self.input = input
        self.output = LoginViewModel.output()
        
        process()
    }
}

private extension LoginViewModel {
    
    static func output() -> LoginViewPresentable.Output {
        return ()
    }
    
    func process() {
        input.login
            .map({ [routingAction] in
                routingAction.loginRelay.accept($0)
            })
            .asObservable()
            .subscribe()
            .disposed(by: bag)
        
        input.forgotPassword
            .map({ [routingAction] in
                routingAction.forgotPasswordRelay.accept($0)
            })
            .asObservable()
            .subscribe()
            .disposed(by: bag)
        
        input.register
            .map({ [routingAction] in
                routingAction.registerRelay.accept($0)
            })
            .asObservable()
            .subscribe()
            .disposed(by: bag)
    }
}
