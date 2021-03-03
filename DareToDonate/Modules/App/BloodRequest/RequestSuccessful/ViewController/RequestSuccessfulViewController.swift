//
//  RequestSuccessfulViewController.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 1.03.2021.
//

import UIKit
import RxSwift
import RxCocoa

final class RequestSuccessfulViewController: UIViewController, Storyboardable {

    private var viewModel: RequestSuccessfulViewPresentable!
    var viewModelBuilder: RequestSuccessfulViewPresentable.ViewModelBuilder!
    
    private let bag = DisposeBag()
        
    override func viewDidLoad() {
        super.viewDidLoad()

    
        viewModel = viewModelBuilder(())
    }
}
