//
//  MembershipTypeSelectionViewController.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 22.02.2021.
//

import UIKit
import RxCocoa

final class MembershipTypeSelectionViewController: UIViewController, Storyboardable {
    
    @IBOutlet private weak var loginButton: UIRoundedButton!
    @IBOutlet private weak var registerButton: UIRoundedButton!

    private var viewModel: MembershipTypeSelectionPresentable!
    var viewModelBuilder: MembershipTypeSelectionPresentable.ViewModelBuilder!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = viewModelBuilder((
            login: loginButton.rx.controlEvent(.touchUpInside),
            register: registerButton.rx.controlEvent(.touchUpInside)
        ))
    
        setupUI()
    }
}

private extension MembershipTypeSelectionViewController {
    
    func setupUI() {
        loginButton.layer.borderWidth = 2
        loginButton.layer.borderColor = UIColor.appPink.cgColor
    }
}
