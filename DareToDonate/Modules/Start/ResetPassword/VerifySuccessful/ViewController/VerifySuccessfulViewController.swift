//
//  VerifySuccessfulViewController.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 24.02.2021.
//

import UIKit

final class VerifySuccessfulViewController: UIViewController, Storyboardable {
    
    @IBOutlet private weak var finishButton: UIRoundedButton!
    
    private var viewModel: VerifySuccessfulViewPresentable!
    var viewModelBuilder: VerifySuccessfulViewPresentable.ViewModelBuilder!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = viewModelBuilder((
            finish: finishButton.rx.controlEvent(.touchUpInside), ()
        ))
    }
}
