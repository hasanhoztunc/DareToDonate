//
//  MembershipTypeSelectionViewModel.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 22.02.2021.
//

import RxCocoa
import RxSwift

protocol MembershipTypeSelectionPresentable {
    
    typealias Input = (
        login: ControlEvent<()>,
        register: ControlEvent<()>
    )
    typealias Output = ()
    typealias ViewModelBuilder = (MembershipTypeSelectionPresentable.Input) -> MembershipTypeSelectionPresentable
    
    var input: MembershipTypeSelectionPresentable.Input { get }
    var output: MembershipTypeSelectionPresentable.Output { get }
}

final class MembershipTypeSelectionViewModel: MembershipTypeSelectionPresentable {
    
    let input: MembershipTypeSelectionPresentable.Input
    let output: MembershipTypeSelectionPresentable.Output
    
    private let bag = DisposeBag()
    
    private typealias RoutingAction = (loginRelay: PublishRelay<()>, registerRelay: PublishRelay<()>)
    private let routingAction: RoutingAction = (loginRelay: PublishRelay(), registerRelay: PublishRelay())
    
    typealias Routing = (login: Driver<()>, register: Driver<()>)
    lazy var routing: Routing = (
        login: routingAction.loginRelay.asDriver(onErrorDriveWith: .empty()),
        register: routingAction.registerRelay.asDriver(onErrorDriveWith: .empty())
    )
    
    init(input: MembershipTypeSelectionPresentable.Input) {
        self.input = input
        self.output = MembershipTypeSelectionViewModel.output()
        
        process()
    }
}

private extension MembershipTypeSelectionViewModel {
    
    static func output() -> MembershipTypeSelectionPresentable.Output {
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
        
        input.register
            .map({ [routingAction] in
                routingAction.registerRelay.accept($0)
            })
            .asObservable()
            .subscribe()
            .disposed(by: bag)
    }
}
