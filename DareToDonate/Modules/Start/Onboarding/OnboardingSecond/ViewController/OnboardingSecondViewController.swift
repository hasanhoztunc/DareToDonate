//
//  OnboardingSecondViewController.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 22.02.2021.
//

import UIKit

final class OnboardingSecondViewController: UIViewController, Storyboardable {
    
    @IBOutlet private weak var firstPage: UIView!
    @IBOutlet private weak var secondPage: UIView!
    
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var skipButton: UIButton!

    private var viewModel: OnboardingSecondViewPresentable!
    var viewModelBuilder: OnboardingSecondViewPresentable.ViewModelBuilder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        viewModel = viewModelBuilder((
            skip: skipButton.rx.controlEvent(.touchUpInside),
            next: nextButton.rx.controlEvent(.touchUpInside)
        ))
    
        setupUI()
    }
}

private extension OnboardingSecondViewController {
    
    func setupUI() {
        firstPage.cornerRadius = firstPage.frame.size.height / 2
        secondPage.cornerRadius = secondPage.frame.size.height / 2
    }
}
