//
//  FindDonorsViewModel.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 26.02.2021.
//
import RxCocoa
import RxSwift

protocol FindDonorsViewPresentable {
    
    typealias Input = ()
    typealias Output = (
        donors: Driver<[DonorSectionModel]>,
        title: Driver<String>
    )
    typealias Dependencies = (title: String, ())
    typealias ViewModelBuilder = (FindDonorsViewPresentable.Input) -> FindDonorsViewPresentable
    
    var input: FindDonorsViewPresentable.Input { get }
    var output: FindDonorsViewPresentable.Output { get }
}

final class FindDonorsViewModel: FindDonorsViewPresentable {
    
    let input: FindDonorsViewPresentable.Input
    let output: FindDonorsViewPresentable.Output
    private let dependencies: FindDonorsViewPresentable.Dependencies
    
    private let bag = DisposeBag()

    init(input: FindDonorsViewPresentable.Input,
         dependencies: FindDonorsViewPresentable.Dependencies) {
        self.input = input
        self.dependencies = dependencies
        self.output = FindDonorsViewModel.output(dependencies: self.dependencies)
    }
}

private extension FindDonorsViewModel {
    
    static func output(dependencies: FindDonorsViewPresentable.Dependencies) -> FindDonorsViewPresentable.Output {
        let donors = [
            DonorViewModel(donorImage: UIImage(named: "donor")!,
                           donorName: "Hasan Oztunc",
                           donorLocation: "Bornova",
                           donorBloodType: "0+"),
            DonorViewModel(donorImage: UIImage(named: "donor")!,
                           donorName: "Hasan Oztunc",
                           donorLocation: "Bornova",
                           donorBloodType: "0+")
        ]
        
        let sections = Observable.just(donors)
            .map({
                [DonorSectionModel(model: 0, items: $0)]
            })
            .asDriver(onErrorJustReturn: [])
        
        return (
            donors: sections,
            title: Driver.just(dependencies.title)
        )
    }
}
