//
//  ReportViewController.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 1.03.2021.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class ReportViewController: UIViewController, Storyboardable {

    private var viewModel: ReportViewPresentable!
    var viewModelBuilder: ReportViewPresentable.ViewModelBuilder!
    
    @IBOutlet private weak var locationTitleLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var myReportButton: UIRoundedButton!
    
    private let bag = DisposeBag()
    
    private static let CellId = "InfoCell"
    
    private lazy var dataSource = RxCollectionViewSectionedReloadDataSource<InfoItemSectionModel> { (dataSource, collectionView, indexPath, item) -> UICollectionViewCell in
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReportViewController.CellId, for: indexPath) as! InfoCell
        
        cell.configure(withViewModel: item)
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = viewModelBuilder(())
        
        setupUI()
        setupBindings()
    }
}

private extension ReportViewController {
    
    func setupUI() {
        collectionView.register(UINib(nibName: "InfoCell", bundle: nil), forCellWithReuseIdentifier: ReportViewController.CellId)
    }
    
    func setupBindings() {
        viewModel.output
            .title
            .drive(self.rx.title)
            .disposed(by: bag)
        
        viewModel.output
            .infoData
            .drive(self.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
    }
}
