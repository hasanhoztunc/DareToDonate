//
//  ProfileViewController.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 2.03.2021.
//

import UIKit
import RxSwift
import RxCocoa

final class ProfileViewController: UIViewController, Storyboardable {

    private var viewModel: ProfileViewPresentable!
    var viewModelBuilder: ProfileViewPresentable.ViewModelBuilder!
    
    private let bag = DisposeBag()
    
    private let editButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        
        button.image = UIImage(named: "ic-edit")
        button.tintColor = .editButton
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = viewModelBuilder(())
 
        setupUI()
        setupBindings()
    }
}

private extension ProfileViewController {
    
    func setupUI() {
        navigationItem.rightBarButtonItem = editButton
    }
    
    func setupBindings() {
        viewModel.output
            .title
            .drive(rx.title)
            .disposed(by: bag)
    }
}
