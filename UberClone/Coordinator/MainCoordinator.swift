//
//  MainCoordinator.swift
//  UberClone
//
//  Created by Fellipe Ricciardi Chiarello on 6/2/20.
//  Copyright © 2020 fchiarello. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func login() {
        let child = LoginCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.parentCoordinator = self 
        child.start()
    }
    
    func create() {
        let vc = CreateAccountViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in
            childCoordinators.enumerated() {
                if coordinator === child {
                    childCoordinators.remove(at: index)
                    break
                }
        }
    }
}
