//
//  ProfileViewModel.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 2.03.2021.
//
import RxSwift
import RxCocoa

protocol ProfileViewPresentable {
    
    typealias Input = ()
    typealias Output = (title: Driver<String>, ())
    typealias Dependencies = (title: String, ())
    typealias ViewModelBuilder = (ProfileViewPresentable.Input) -> ProfileViewPresentable

    var input: ProfileViewPresentable.Input { get }
    var output: ProfileViewPresentable.Output { get }
}

final class ProfileViewModel: ProfileViewPresentable {
    
    let input: ProfileViewPresentable.Input
    let output: ProfileViewPresentable.Output

    init(input: ProfileViewPresentable.Input,
         dependencies: ProfileViewPresentable.Dependencies) {
        self.input = input
        self.output = ProfileViewModel.output(dependencies: dependencies)
    }
}

private extension ProfileViewModel {
    
    static func output(dependencies: ProfileViewPresentable.Dependencies) -> ProfileViewPresentable.Output {
        return (
            title: Driver.just(dependencies.title), ()
        )
    }
}
