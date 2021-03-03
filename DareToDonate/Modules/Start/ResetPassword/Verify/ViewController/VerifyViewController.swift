//
//  VerifyViewController.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 23.02.2021.
//

import UIKit

final class VerifyViewController: UIViewController, Storyboardable {
    
    @IBOutlet private weak var digit1TextField: UIRoundedTextField!
    @IBOutlet private weak var digit2TextField: UIRoundedTextField!
    @IBOutlet private weak var digit3TextField: UIRoundedTextField!
    @IBOutlet private weak var digit4TextField: UIRoundedTextField!
    @IBOutlet private weak var resendCodeLabel: UILabel!
    @IBOutlet private weak var verifyButton: UIRoundedButton!
    
    private var viewModel: VerifyViewPresentable!
    var viewModelBuilder: VerifyViewPresentable.ViewModelBuilder!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = viewModelBuilder((
            digit1: digit1TextField.rx.text.orEmpty.asDriver(),
            digit2: digit2TextField.rx.text.orEmpty.asDriver(),
            digit3: digit3TextField.rx.text.orEmpty.asDriver(),
            digit4: digit4TextField.rx.text.orEmpty.asDriver(),
            verify: verifyButton.rx.controlEvent(.touchUpInside)
        ))
    }
}
