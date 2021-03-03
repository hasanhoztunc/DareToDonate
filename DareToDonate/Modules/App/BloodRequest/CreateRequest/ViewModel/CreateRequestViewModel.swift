//
//  CreateRequestViewModel.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 1.03.2021.
//
import RxSwift
import RxCocoa

protocol CreateRequestViewPresentable {
    
    typealias Input = (
        city: Driver<String>,
        hospital: Driver<String>,
        bloodType: Driver<String>,
        mobile: Driver<String>,
        note: Driver<String>,
        request: ControlEvent<()>
    )
    typealias Output = (title: Driver<String>, ())
    typealias Dependencies = (title: String, ())
    typealias ViewModelBuilder = (CreateRequestViewPresentable.Input) -> CreateRequestViewPresentable
    
    var input: CreateRequestViewPresentable.Input { get }
    var output: CreateRequestViewPresentable.Output { get }
}

final class CreateRequestViewModel: CreateRequestViewPresentable {
    
    let input: CreateRequestViewPresentable.Input
    let output: CreateRequestViewPresentable.Output
    
    private let bag = DisposeBag()
    
    private typealias RoutingAction = (routeRelay: PublishRelay<Void>, ())
    private let routingAction: RoutingAction = (routeRelay: PublishRelay(), ())
    
    typealias Routing = (route: Driver<Void>, ())
    lazy var routing: Routing = (routingAction.routeRelay.asDriver(onErrorDriveWith: .empty()), ())

    init(input: CreateRequestViewPresentable.Input,
         dependencies: CreateRequestViewPresentable.Dependencies) {
        self.input = input
        self.output = CreateRequestViewModel.output(dependencies: dependencies)
        
        process()
    }
}

private extension CreateRequestViewModel {
    
    static func output(dependencies: CreateRequestViewPresentable.Dependencies) -> CreateRequestViewPresentable.Output {
        return (
            title: Driver.just(dependencies.title), ()
        )
    }
    
    func process() {
        input.request
            .map({ [routingAction] in
                routingAction.routeRelay.accept($0)
            })
            .subscribe()
            .disposed(by: bag)
    }
}
