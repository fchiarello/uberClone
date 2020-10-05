//
//  PassengerViewController.swift
//  UberClone
//
//  Created by Fellipe Ricciardi Chiarello on 7/8/20.
//  Copyright © 2020 fchiarello. All rights reserved.
//

import UIKit
import FirebaseAuth

class PassengerViewController: UIViewController, Storyboarded {

    var coordinator: PassengerCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        // Do any additional setup after loading the view.
    }

    func setupNavigationBar() {
        let button = UIBarButtonItem(title: "logout", style: .plain, target: self, action: #selector(appLogout))
        navigationItem.leftBarButtonItem = button
        navigationItem.title = "UBER"
    }
    
    @objc func appLogout() {
        let auth = Auth.auth()
        do {
            try auth.signOut()
            coordinator?.dismiss()
            print("Deslogado")            
        } catch  {
            print("erro ao deslogar")
        }
    }

}
