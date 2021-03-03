//
//  DonationRequestViewController.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 26.02.2021.
//

import UIKit
import RxSwift
import RxDataSources

final class DonationRequestViewController: UIViewController, Storyboardable {

    private var viewModel: DonationRequestViewPresentable!
    var viewModelBuilder: DonationRequestViewPresentable.ViewModelBuilder!
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let bag = DisposeBag()
    
    private static let CellId = "DonationRequestCell"
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<DonationRequestItemSection>(configureCell: {
        (_, tableView, indexPath, item) in
        
        let requestCell = tableView.dequeueReusableCell(withIdentifier: DonationRequestViewController.CellId, for: indexPath) as! DonationRequestCell
        
        requestCell.configure(withViewModel: item)
        
        return requestCell
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        viewModel = viewModelBuilder(())
    
        setupUI()
        setupBindings()
    }
}

private extension DonationRequestViewController {
    
    func setupUI() {
        tableView.register(UINib(nibName: "DonationRequestCell", bundle: nil), forCellReuseIdentifier: DonationRequestViewController.CellId)
    }
    
    func setupBindings() {
        viewModel.output
            .donationRequests
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
        
        viewModel.output
            .title
            .drive(self.rx.title)
            .disposed(by: bag)
    }
}
