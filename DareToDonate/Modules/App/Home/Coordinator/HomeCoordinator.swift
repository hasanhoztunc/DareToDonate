//
//  HomeCoordinator.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 24.02.2021.
//

import UIKit
import RxCocoa
import RxSwift

final class HomeCoordinator: BaseCoordinator {
    
    private let router: Routing
    
    private let bag = DisposeBag()
    
    init(router: Routing) {
        self.router = router
    }
    
    override func start() {
        let view = HomeViewController.instantiate(from: "Home")
        
        view.viewModelBuilder = { [bag] in
            let viewModel = HomeViewModel(input: $0)
            
            viewModel.routing
                .route
                .map({ [weak self] in
                    guard let self = self else { return }
                    switch $0 {
                    case .request:
                        self.showDonationRequests()
                    case .search:
                        self.showFindDonors()
                    case .report:
                        self.showReport()
                    case .createRequest:
                        self.showCreateRequest()
                    case .profile:
                        self.showProfile()
                    case .home, .order:
                        break
                    }
                })
                .drive()
                .disposed(by: bag)
            
            return viewModel
        }
        
        router.push(view, isAnimated: true, onNavigationBack: isCompleted)
    }
}

private extension HomeCoordinator {
    
    func showDonationRequests() {
        let donationRequestCoordinator = DonationRequestCoordinator(router: router)
        self.add(coordinator: donationRequestCoordinator)
        
        donationRequestCoordinator.isCompleted = { [weak self, weak donationRequestCoordinator] in
            guard let coordinator = donationRequestCoordinator,
                  let self = self else { return }
            self.remove(coordinator: coordinator)
        }
        
        donationRequestCoordinator.start()
    }
    
    func showFindDonors() {
        let findDonorsCoordinator = FindDonorsCoordinator(router: router)
        self.add(coordinator: findDonorsCoordinator)
        
        findDonorsCoordinator.isCompleted = { [weak self, weak findDonorsCoordinator] in
            guard let coordinator = findDonorsCoordinator,
                  let self = self else { return }
            self.remove(coordinator: coordinator)
        }
        
        findDonorsCoordinator.start()
    }
    
    func showReport() {
        let reportCoordinator = ReportCoordinator(router: router)
        self.add(coordinator: reportCoordinator)
        
        reportCoordinator.isCompleted = { [weak self, weak reportCoordinator] in
            guard let coordinator = reportCoordinator,
                  let self = self else { return }
            self.remove(coordinator: coordinator)
        }
        
        reportCoordinator.start()
    }
    
    func showCreateRequest() {
        let createRequestCoordinator = CreateRequestCoordinator(router: router)
        self.add(coordinator: createRequestCoordinator)
        
        createRequestCoordinator.isCompleted = { [weak self, weak createRequestCoordinator] in
            guard let coordinator = createRequestCoordinator,
                  let self = self else { return }
            self.remove(coordinator: coordinator)
        }
        
        createRequestCoordinator.start()
    }
    
    func showProfile() {
        let profileCoordinator = ProfileCoordinator(router: router)
        self.add(coordinator: profileCoordinator)
        
        profileCoordinator.isCompleted = { [weak self, weak profileCoordinator] in
            guard let coordinator = profileCoordinator,
                  let self = self else { return }
            self.remove(coordinator: coordinator)
        }
        
        profileCoordinator.start()
    }
}
