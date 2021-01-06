//
//  DriverCoordinator.swift
//  UberClone
//
//  Created by Fellipe Ricciardi Chiarello on 11/2/20.
//  Copyright © 2020 fchiarello. All rights reserved.
//

import Foundation
import UIKit

class DriverCoordinator: Coordinator {
   
    weak var parentCoordinator: MainCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
  
    func start() {
        let vc = DriverViewController()
        vc.coordinator = self
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func dismiss() {
        let vc = DriverViewController()
        vc.coordinator = self
        
        navigationController.popViewController(animated: true)
    }
}
