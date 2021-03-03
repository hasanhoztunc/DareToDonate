//
//  RegisterViewController.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 23.02.2021.
//

import UIKit

final class RegisterViewController: UIViewController, Storyboardable {
    
    @IBOutlet private weak var firstLastNameTextField: UIRoundedTextField!
    @IBOutlet private weak var emailTextField: UIRoundedTextField!
    @IBOutlet private weak var passwordTextField: UIRoundedTextField!
    @IBOutlet private weak var phoneNumberTextField: UIRoundedTextField!
    @IBOutlet private weak var bloodTypeTextField: UIRoundedTextField!
    @IBOutlet private weak var locationTextField: UIRoundedTextField!
    @IBOutlet private weak var registerButton: UIRoundedButton!
    @IBOutlet private weak var loginButton: UIButton!
    
    private var viewModel: RegisterViewPresentable!
    var viewModelBuilder: RegisterViewPresentable.ViewModelBuilder!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = viewModelBuilder((
            firstLastName: firstLastNameTextField.rx.text.orEmpty.asDriver(),
            email: emailTextField.rx.text.orEmpty.asDriver(),
            password: passwordTextField.rx.text.orEmpty.asDriver(),
            phoneNumber: passwordTextField.rx.text.orEmpty.asDriver(),
            bloodType: bloodTypeTextField.rx.text.orEmpty.asDriver(),
            location: locationTextField.rx.text.orEmpty.asDriver(),
            register: registerButton.rx.controlEvent(.touchUpInside),
            logIn: loginButton.rx.controlEvent(.touchUpInside)
        ))
        
        setupUI()
    }
}

private extension RegisterViewController {
    
    func setupUI() {
        firstLastNameTextField.leftIcon(icon: "ic-person")
        emailTextField.leftIcon(icon: "ic-mail")
        passwordTextField.leftIcon(icon: "ic-password")
        phoneNumberTextField.leftIcon(icon: "ic-phone")
        bloodTypeTextField.leftIcon(icon: "ic-blood")
        locationTextField.leftIcon(icon: "ic-location")
    }
}
