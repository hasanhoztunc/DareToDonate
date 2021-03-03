//
//  HomeViewModel.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 24.02.2021.
//
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

enum HomeRoutes {
    case home
    case search
    case order
    case request
    case profile
    case report
    case createRequest
}

typealias CategoriesItemSection = SectionModel<Int, CategoriesViewPresentable>

protocol HomeViewPresentable {
    
    typealias Input = (
        selectTab: ControlEvent<UITabBarItem>,
        selectCategory: ControlEvent<IndexPath>
    )
    typealias Output = (
        categories: Driver<[CategoriesItemSection]>, ()
    )
    typealias ViewModelBuilder = (HomeViewPresentable.Input) -> HomeViewPresentable
    
    var input: HomeViewPresentable.Input { get }
    var output: HomeViewPresentable.Output { get }
}

final class HomeViewModel: HomeViewPresentable {
    
    let input: HomeViewPresentable.Input
    let output: HomeViewPresentable.Output
    
    private let bag = DisposeBag()
    
    private typealias RoutingAction = (routeRelay: PublishRelay<HomeRoutes>, ())
    private let routingAction: RoutingAction = (routeRelay: PublishRelay(), ())

    typealias Routing = (route: Driver<HomeRoutes>, ())
    lazy var routing: Routing = (route: routingAction.routeRelay.asDriver(onErrorDriveWith: .empty()), ())
    
    init(input: HomeViewPresentable.Input) {
        self.input = input
        self.output = HomeViewModel.output()
    
        process()
    }
}

private extension HomeViewModel {
    
    static func output() -> HomeViewPresentable.Output {
        
        let sections = Observable.just([
            CategoriesViewModel(image: UIImage(named: "ic-finddonors")!, title: "Find Donors"),
            CategoriesViewModel(image: UIImage(named: "ic-donates")!, title: "Donates"),
            CategoriesViewModel(image: UIImage(named: "ic-orderblood")!, title: "Order Bloods"),
            CategoriesViewModel(image: UIImage(named: "ic-assistant")!, title: "Assistant"),
            CategoriesViewModel(image: UIImage(named: "ic-report")!, title: "Report"),
            CategoriesViewModel(image: UIImage(named: "ic-campaign")!, title: "Campaign"),
        ])
        .map({
            [CategoriesItemSection(model: 0, items: $0)]
        })
        .asDriver(onErrorJustReturn: [])
        
        return (
            categories: sections, ()
        )
    }
    
    func process() {
        input.selectTab
            .map({ [routingAction] tab in
                if tab.tag == 101 { routingAction.routeRelay.accept(HomeRoutes.search) }
                if tab.tag == 102 { routingAction.routeRelay.accept(HomeRoutes.order) }
                if tab.tag == 103 { routingAction.routeRelay.accept(HomeRoutes.request) }
                if tab.tag == 104 { routingAction.routeRelay.accept(HomeRoutes.profile) }
            })
            .asObservable()
            .subscribe()
            .disposed(by: bag)
    
        input.selectCategory
            .map({ [routingAction] category in
                if category == IndexPath(item: 4, section: 0) { routingAction.routeRelay.accept(HomeRoutes.report) }
                if category == IndexPath(item: 2, section: 0) { routingAction.routeRelay.accept(HomeRoutes.createRequest) }
            })
            .asObservable()
            .subscribe()
            .disposed(by: bag)
    }
}
