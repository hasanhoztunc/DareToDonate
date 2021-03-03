//
//  AppCoordinator.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 22.02.2021.
//

import UIKit

final class AppCoordinator: BaseCoordinator {
    
    private let window: UIWindow
    private let navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        
        let navigationBar = navigationController.navigationBar
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.barTintColor = .white
        navigationBar.tintColor = .white
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 22)!,
            NSAttributedString.Key.foregroundColor: UIColor.textFieldText
        ]
        navigationBar.isTranslucent = false
        
        let backImage = UIImage(named: "ic-back")!
        
        navigationBar.backIndicatorImage = backImage
        navigationBar.backIndicatorTransitionMaskImage = backImage
        navigationBar.backItem?.title = nil
        
        return navigationController
    }()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        let router = Router(navigationController: navigationController)
        
        /*let onBoardingCoordinator = OnboardingFirstCoordinator(router: router)
        self.add(coordinator: onBoardingCoordinator)
        
        onBoardingCoordinator.isCompleted = { [weak self, weak onBoardingCoordinator] in
            guard let coordinator = onBoardingCoordinator else { return }
            self?.remove(coordinator: coordinator)
        }
        
        onBoardingCoordinator.start()*/
        let homeCoordinator = HomeCoordinator(router: router)
        self.add(coordinator: homeCoordinator)
        
        homeCoordinator.isCompleted = { [weak self, weak homeCoordinator] in
            guard let coordinator = homeCoordinator,
                  let self = self else { return }
            self.remove(coordinator: coordinator)
        }
        
        homeCoordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
