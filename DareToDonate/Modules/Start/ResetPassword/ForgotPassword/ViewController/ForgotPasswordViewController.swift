//
//  ForgotPasswordViewController.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 23.02.2021.
//

import UIKit

final class ForgotPasswordViewController: UIViewController, Storyboardable {
    
    @IBOutlet private weak var emailTextField: UIRoundedTextField!
    @IBOutlet private weak var sendButton: UIRoundedButton!
    
    private var viewModel: ForgotPasswordViewPresentable!
    var viewModelBuilder: ForgotPasswordViewPresentable.ViewModelBuilder!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = viewModelBuilder((
            email: emailTextField.rx.text.orEmpty.asDriver(),
            send: sendButton.rx.controlEvent(.touchUpInside)
        ))
        
        setupUI()
    }
}

private extension ForgotPasswordViewController {
    
    func setupUI() {
        emailTextField.leftIcon(icon: "ic-mail")
    }
}
