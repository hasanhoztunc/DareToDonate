//
//  BaseCoordinator.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 22.02.2021.
//

class BaseCoordinator: Coordinator {
    
    var childCoordinator: [Coordinator] = []
    var isCompleted: (() -> ())?
    
    func start() {
        fatalError("Children should implement 'start'")
    }
}
