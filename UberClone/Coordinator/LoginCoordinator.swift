//
//  LoginCoordinator.swift
//  UberClone
//
//  Created by Fellipe Ricciardi Chiarello on 6/18/20.
//  Copyright © 2020 fchiarello. All rights reserved.
//

import Foundation
import UIKit

class LoginCoordinator: Coordinator {
    
    weak var parentCoordinator: MainCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = LoginViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
//    func didFinishLogin() {
//        parentCoordinator?.childDidFinish(self)
//    }
    
    
}

