//
//  HomeViewController.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 24.02.2021.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

final class HomeViewController: UIViewController, Storyboardable {

    @IBOutlet private weak var customScrollViewView: UIView!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var customTabbar: UITabBar!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var tableView: UITableView!
    
    private let bag = DisposeBag()
    private static let CellId = "CategoriesCollectionViewCell"
    
    private lazy var categoriesDataSource = RxCollectionViewSectionedReloadDataSource<CategoriesItemSection> { (dataSource, collectionView, indexPath, item) -> UICollectionViewCell in
        
        let categoriesCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeViewController.CellId, for: indexPath) as! CategoriesCollectionViewCell
        
        categoriesCell.configureCell(usingViewModel: item)
    
        return categoriesCell
    }
    
    private var viewModel: HomeViewPresentable!
    var viewModelBuilder: HomeViewPresentable.ViewModelBuilder!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = viewModelBuilder((
            selectTab: customTabbar.rx.didSelectItem,
            selectCategory: collectionView.rx.itemSelected
        ))

        setupBindings()

        setupUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let safeFrame = customScrollViewView.safeAreaLayoutGuide.layoutFrame
        scrollView.frame = safeFrame
    }
}

private extension HomeViewController {
    
    func setupBindings() {
        viewModel.output
            .categories
            .drive(collectionView.rx.items(dataSource: categoriesDataSource))
            .disposed(by: bag)
    }
    
    func setupUI() {
        navigationController?.isNavigationBarHidden = false
        customTabbar.selectedItem = customTabbar.items?.first
        
        let appearance = customTabbar.standardAppearance
        appearance.shadowImage = nil
        appearance.shadowColor = nil
        appearance.backgroundColor = .clear
        
        customTabbar.standardAppearance = appearance
        
        setupNavigationBarButtons()
        
        setupCarousel()
        
        setupCollectionView()
    }
    func setupCollectionView() {
        collectionView.register(UINib(nibName: "CategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: HomeViewController.CellId)
    }
}

private extension HomeViewController {
    func setupNavigationBarButtons() {
        let ringIcon = UIImage(named: "ic-ring")
        let ring = UIBarButtonItem()
        ring.image = ringIcon
        
        navigationItem.rightBarButtonItem  = ring
        
        let leftIcon = UIImage(named: "ic-foursquares")
        let leftButton = UIBarButtonItem()
        leftButton.image = leftIcon
        
        navigationItem.leftBarButtonItem = leftButton
    }
}

private extension HomeViewController {
    func setupCarousel() {
        customScrollViewView.cornerRadius = 10
        
        scrollView.removeConstraints(scrollView.constraints)
        scrollView.translatesAutoresizingMaskIntoConstraints = true
        
        scrollView.contentSize = CGSize(width: (customScrollViewView.frame.size.width * CGFloat(pageControl.numberOfPages)),
                                        height: (customScrollViewView.frame.size.height))
        
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        
        var images: [UIImage] = []
        for _ in 1...pageControl.numberOfPages {
            images.append(UIImage(named: "carousel2")!)
        }
        for (index, image) in images.enumerated() {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFill
            imageView.frame = CGRect(x: (customScrollViewView.frame.size.width * CGFloat(index)),
                                     y: 0,
                                     width: (customScrollViewView.frame.size.width),
                                     height: (customScrollViewView.frame.size.height))
            scrollView.addSubview(imageView)
        }
        
        scrollView.rx.didScroll
            .map({ [weak self] in
                guard let self = self else { return }
                let width = self.scrollView.bounds.size.width
                let page = Int((self.scrollView.contentOffset.x + width / 2) / width)
            
                self.pageControl.currentPage = page
            })
            .subscribe()
            .disposed(by: bag)
    }
}
