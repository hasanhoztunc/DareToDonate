//
//  Coordinator.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 22.02.2021.
//

protocol Coordinator: class {
    
    var childCoordinator: [Coordinator] { get set }
    
    func start()
}

extension Coordinator {
    
    func add(coordinator: Coordinator) {
        childCoordinator.append(coordinator)
    }
    
    func remove(coordinator: Coordinator) {
        childCoordinator = childCoordinator.filter({ $0 !== coordinator })
    }
}
