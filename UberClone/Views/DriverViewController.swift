//
//  DriverViewController.swift
//  UberClone
//
//  Created by Fellipe Ricciardi Chiarello on 11/2/20.
//  Copyright © 2020 fchiarello. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import MapKit

class DriverViewController: UIViewController, Storyboarded {

    var coordinator: DriverCoordinator?
    var locationManager = CLLocationManager()
    var userLocation = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        let button = UIBarButtonItem(title: "logout", style: .plain, target: self, action: #selector(appLogout))
        navigationItem.leftBarButtonItem = button
        navigationItem.title = "Requests"
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
