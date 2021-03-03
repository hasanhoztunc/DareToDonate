//
//  DonationRequestViewModel.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 26.02.2021.
//
import RxSwift
import RxCocoa
import RxDataSources

protocol DonationRequestViewPresentable {
    
    typealias Input = ()
    typealias Output = (
        donationRequests: Driver<[DonationRequestItemSection]>,
        title: Driver<String>
    )
    typealias Dependencies = (
        title: String, ()
    )
    typealias ViewModelBuilder = (DonationRequestViewPresentable.Input) -> DonationRequestViewPresentable
    
    var input: DonationRequestViewPresentable.Input { get }
    var output: DonationRequestViewPresentable.Output { get }
}

final class DonationRequestViewModel: DonationRequestViewPresentable {
    let input: DonationRequestViewPresentable.Input
    let output: DonationRequestViewPresentable.Output
    let dependencies: DonationRequestViewPresentable.Dependencies

    init(input: DonationRequestViewPresentable.Input,
         dependencies: DonationRequestViewPresentable.Dependencies) {
        self.input = input
        self.dependencies = dependencies
        self.output = DonationRequestViewModel.output(dependencies: self.dependencies)
    }
}

private extension DonationRequestViewModel {
    
    static func output(dependencies: DonationRequestViewPresentable.Dependencies) -> DonationRequestViewPresentable.Output {
        let requests = [DonationRequestCellViewModel(name: "Amir Hamza",
                                                     location: "Herford British Hospital",
                                                     time: "5 Min Ago",
                                                     bloodType: "B+"),
                        DonationRequestCellViewModel(name: "Amir Hamza",
                                                                     location: "Herford British Hospital",
                                                                     time: "5 Min Ago",
                                                                     bloodType: "B+")
                        ]
        let sections = Observable.just(requests)
            .map({
                [DonationRequestItemSection(model: 0, items: $0)]
            })
            .asDriver(onErrorJustReturn: [])
        
        return (
            donationRequests: sections,
            title: Driver.just(dependencies.title)
        )
    }
}
