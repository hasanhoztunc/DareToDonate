//
//  RegisterViewModel.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 23.02.2021.
//
import RxSwift
import RxCocoa

protocol RegisterViewPresentable {
    
    typealias Input = (
        firstLastName: Driver<String>,
        email: Driver<String>,
        password: Driver<String>,
        phoneNumber: Driver<String>,
        bloodType: Driver<String>,
        location: Driver<String>,
        register: ControlEvent<()>,
        logIn: ControlEvent<()>
    )
    typealias Output = ()
    typealias ViewModelBuilder = (RegisterViewPresentable.Input) -> RegisterViewPresentable
    
    var input: RegisterViewPresentable.Input { get }
    var output: RegisterViewPresentable.Output { get }
}

final class RegisterViewModel: RegisterViewPresentable {
    
    let input: RegisterViewPresentable.Input
    let output: RegisterViewPresentable.Output
    
    private let bag = DisposeBag()
    
    private typealias RoutingAction = (registerRelay: PublishRelay<()>, logInRelay: PublishRelay<()>)
    private let routingAction: RoutingAction = (registerRelay: PublishRelay(), logInRelay: PublishRelay())
    
    typealias Routing = (register: Driver<()>, logIn: Driver<()>)
    lazy var routing: Routing = (
        register: routingAction.registerRelay.asDriver(onErrorDriveWith: .empty()),
        logIn: routingAction.logInRelay.asDriver(onErrorDriveWith: .empty())
    )
    
    init(input: RegisterViewPresentable.Input) {
        self.input = input
        self.output = RegisterViewModel.output()
        
        process()
    }
}

private extension RegisterViewModel {
    
    static func output() -> RegisterViewPresentable.Output {
        return ()
    }
    
    func process() {
        input.register
            .map({ [routingAction] in
                routingAction.registerRelay.accept($0)
            })
            .asObservable()
            .subscribe()
            .disposed(by: bag)
        
        input.logIn
            .map({ [routingAction] in
                routingAction.logInRelay.accept($0)
            })
            .asObservable()
            .subscribe()
            .disposed(by: bag)
    }
}
