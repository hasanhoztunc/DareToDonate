//
//  CreateRequestViewController.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 1.03.2021.
//

import UIKit
import RxSwift
import RxCocoa

final class CreateRequestViewController: UIViewController, Storyboardable {
    
    @IBOutlet private weak var cityTextField: UIRoundedTextField!
    @IBOutlet private weak var hospitalTextField: UIRoundedTextField!
    @IBOutlet private weak var bloodTypeTextField: UIRoundedTextField!
    @IBOutlet private weak var mobileTextField: UIRoundedTextField!
    @IBOutlet private weak var noteTextView: UITextView!
    @IBOutlet private weak var requestButton: UIButton!

    private var viewModel: CreateRequestViewPresentable!
    var viewModelBuilder: CreateRequestViewPresentable.ViewModelBuilder!
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = viewModelBuilder((
            city: cityTextField.rx.text.orEmpty.asDriver(),
            hospital: hospitalTextField.rx.text.orEmpty.asDriver(),
            bloodType: bloodTypeTextField.rx.text.orEmpty.asDriver(),
            mobile: mobileTextField.rx.text.orEmpty.asDriver(),
            note: noteTextView.rx.text.orEmpty.asDriver(),
            request: requestButton.rx.controlEvent(.touchUpInside)
        ))
        
        setupBindings()
    }
}

private extension CreateRequestViewController {

    func setupBindings() {
        viewModel.output
            .title
            .drive(rx.title)
            .disposed(by: bag)
    }
}
