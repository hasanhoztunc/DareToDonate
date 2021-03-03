//
//  OnboardingFirstViewController.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 22.02.2021.
//

import UIKit
import RxCocoa
import RxSwift

final class OnboardingFirstViewController: UIViewController, Storyboardable {

    @IBOutlet private weak var firstPage: UIView!
    @IBOutlet private weak var secondPage: UIView!
    
    @IBOutlet private weak var skipButton: UIButton!
    @IBOutlet private weak var nextButton: UIButton!
    
    private var viewModel: OnboardingFirstPresentable!
    var viewModelBuilder: OnboardingFirstPresentable.ViewModelBuilder!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = viewModelBuilder((
            skip: skipButton.rx.controlEvent(.touchUpInside),
            next: nextButton.rx.controlEvent(.touchUpInside)
        ))
        
        setupUI()
    }
}

private extension OnboardingFirstViewController {
    
    func setupUI() {
        self.navigationController?.isNavigationBarHidden = true
        firstPage.cornerRadius = secondPage.frame.size.height / 2
        secondPage.cornerRadius = secondPage.frame.size.height / 2
    }
}
