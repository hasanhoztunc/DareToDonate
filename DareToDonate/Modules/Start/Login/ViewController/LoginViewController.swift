//
//  LoginViewController.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 23.02.2021.
//

import UIKit

final class LoginViewController: UIViewController, Storyboardable {
    
    @IBOutlet private weak var emailTextField: UIRoundedTextField!
    @IBOutlet private weak var passwordTextField: UIRoundedTextField!
    @IBOutlet private weak var logInButton: UIRoundedButton!
    @IBOutlet private weak var forgotPasswordButton: UIButton!
    @IBOutlet private weak var registerButton: UIButton!

    private var viewModel: LoginViewPresentable!
    var viewModelBuilder: LoginViewPresentable.ViewModelBuilder!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = viewModelBuilder((
            email: emailTextField.rx.text.orEmpty.asDriver(),
            password: passwordTextField.rx.text.orEmpty.asDriver(),
            login: logInButton.rx.controlEvent(.touchUpInside),
            forgotPassword: forgotPasswordButton.rx.controlEvent(.touchUpInside),
            register: registerButton.rx.controlEvent(.touchUpInside)
        ))
        
        setupUI()
    }
}

private extension LoginViewController {
    
    func setupUI() {
        forgotPasswordButton.titleLabel?.adjustsFontSizeToFitWidth = true
        registerButton.titleLabel?.adjustsFontSizeToFitWidth = true

        emailTextField.leftIcon(icon: "ic-mail")
        passwordTextField.leftIcon(icon: "ic-password")
    }
}
