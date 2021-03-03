//
//  ReportViewModel.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 1.03.2021.
//
import RxCocoa
import RxSwift

protocol ReportViewPresentable {
    
    typealias Input = ()
    typealias Output = (
        title: Driver<String>,
        infoData: Driver<[InfoItemSectionModel]>
    )
    typealias Dependencies = (title: String, ())
    typealias ViewModelBuilder = (ReportViewPresentable.Input) -> ReportViewPresentable
    
    var input: ReportViewPresentable.Input { get }
    var output: ReportViewPresentable.Output { get }
}

final class ReportViewModel: ReportViewPresentable {
    
    let input: ReportViewPresentable.Input
    let output: ReportViewPresentable.Output

    private let bag = DisposeBag()
    
    init(input: ReportViewPresentable.Input,
         dependencies: ReportViewPresentable.Dependencies) {
        self.input = input
        self.output = ReportViewModel.output(dependencies: dependencies)
    }
}

private extension ReportViewModel {
    
    static func output(dependencies: ReportViewPresentable.Dependencies) -> ReportViewPresentable.Output {
        
        let infoCellDatas = [
            InfoViewCellViewModel(infoValue: "6 mmol/L", infoTitle: "Glucose"),
            InfoViewCellViewModel(infoValue: "6.2 mmol/L", infoTitle: "Cholesterol"),
            InfoViewCellViewModel(infoValue: "12 mmol/L", infoTitle: "Bilirubin"),
            InfoViewCellViewModel(infoValue: "3 ml/L", infoTitle: "RBC"),
            InfoViewCellViewModel(infoValue: "102 fl", infoTitle: "MVC"),
            InfoViewCellViewModel(infoValue: "276 bL", infoTitle: "Platalets")
        ]
        
        let sections = Driver.just(infoCellDatas)
            .map({
                [InfoItemSectionModel(model: 0, items: $0)]
            })
            .asDriver(onErrorJustReturn: [])
        
        return (
            title: Driver.just(dependencies.title),
            infoData: sections
        )
    }
}
