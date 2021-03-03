//
//  RequestSuccessfulViewModel.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 1.03.2021.
//
import RxSwift
import RxCocoa

protocol RequestSuccessfulViewPresentable {
    
    typealias Input = ()
    typealias Output = ()
    typealias ViewModelBuilder = (RequestSuccessfulViewPresentable.Input) -> RequestSuccessfulViewPresentable
    
    var input: RequestSuccessfulViewPresentable.Input { get }
    var output: RequestSuccessfulViewPresentable.Output { get }
}

final class RequestSuccessfulViewModel: RequestSuccessfulViewPresentable {
    
    let input: RequestSuccessfulViewPresentable.Input
    let output: RequestSuccessfulViewPresentable.Output

    init(input: RequestSuccessfulViewPresentable.Input) {
        self.input = input
        self.output = RequestSuccessfulViewModel.output()
    }
}

private extension RequestSuccessfulViewModel {
    
    static func output() -> RequestSuccessfulViewPresentable.Output {
        return ()
    }
}
