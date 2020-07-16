//
//  ViewController.swift
//  UberClone
//
//  Created by Fellipe Ricciardi Chiarello on 6/2/20.
//  Copyright © 2020 fchiarello. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController, Storyboarded {
    
    var coordinator: MainCoordinator?
    
    @IBAction func entrarTapped(_ sender: Any) {
        coordinator?.login()
    }
    
    @IBAction func cadastrarTapped(_ sender: Any) {
        coordinator?.create()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        didLoggedIn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func didLoggedIn() {
        let auth = Auth.auth()
//        do {
//            try auth.signOut()
//        } catch  {
//            
//        }
        
        auth.addStateDidChangeListener { (auth, user) in
            if user != nil {
                self.coordinator?.passenger()
            }
        }
    }
    
}

