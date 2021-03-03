//
//  FindDonorsViewController.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 26.02.2021.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class FindDonorsViewController: UIViewController, Storyboardable {
    
    private var viewModel: FindDonorsViewPresentable!
    var viewModelBuilder: FindDonorsViewPresentable.ViewModelBuilder!
    
    @IBOutlet private weak var filtersView: UIView!
    @IBOutlet private weak var bloodTypesCollectionView: UICollectionView!
    @IBOutlet private weak var applyButton: UIRoundedButton!
    
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var filterButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    
    private let bag = DisposeBag()
    
    private static let CellId = "DonorCell"
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<DonorSectionModel>(configureCell: {
        (_, tableView, indexPath, item) in
        let cell = tableView.dequeueReusableCell(withIdentifier: FindDonorsViewController.CellId, for: indexPath) as! DonorCell
        
        cell.configure(withViewModel: item)
        
        return cell
    })

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = viewModelBuilder(())
    
        setupUI()
        setupBindings()
    }
}

private extension FindDonorsViewController {
    
    func setupUI() {
        filtersView.setShadow(color: .shadow)
        filtersView.cornerRadius = 10
        
        filterButton.cornerRadius = 5
        
        searchTextField.leftIcon(icon: "ic-search", size: CGRect(x: 0, y: 0, width: 93, height: 48))
        searchTextField.setShadow(color: .shadow)
        
        tableView.register(UINib(nibName: "DonorCell", bundle: nil), forCellReuseIdentifier: FindDonorsViewController.CellId)
        
        filterButton.rx
            .controlEvent(.touchUpInside)
            .map({ [weak self] in
                guard let self = self else { return }
                self.tableView.isHidden.toggle()
                if self.tableView.isHidden {
                    self.view.addSubview(self.filtersView)
                    self.addFiltersViewConstraints()
                } else {
                    self.filtersView.removeFromSuperview()
                }
            })
            .asObservable()
            .subscribe()
            .disposed(by: bag)
    }
    
    func setupBindings() {
        viewModel.output
            .title
            .drive(self.rx.title)
            .disposed(by: bag)
        
        viewModel.output
            .donors
            .drive(self.tableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
    }
}

private extension FindDonorsViewController {
    
    func addFiltersViewConstraints() {
        filtersView.layer.frame = CGRect(x: 20,
                                         y: searchTextField.frame.midY * 2,
                                         width: view.bounds.size.width - 40,
                                         height: view.bounds.size.height - ((searchTextField.frame.midY * 2) + 82))
    }
}
