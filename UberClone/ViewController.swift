//
//  ViewController.swift
//  UberClone
//
//  Created by Fellipe Ricciardi Chiarello on 6/2/20.
//  Copyright © 2020 fchiarello. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController, Storyboarded {
    
    var coordinator: MainCoordinator?
    
    let auth = Auth.auth()
    let database = Database.database().reference()
    
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
        self.auth.addStateDidChangeListener { (auth, user) in
            if let usuario = user {
                let users = self.database.child(UberConstants.kuser).child(usuario.uid)
                users.observeSingleEvent(of: .value) { (snapshot) in
                    let data = snapshot.value as? NSDictionary
                    guard let userType = data?[UberConstants.kType] as? String else {return}
                    if userType == UberConstants.kDriver {
                        self.coordinator?.driver()
                    } else {
                        self.coordinator?.passenger()
                    }
                }
            }
        }
    }
    
    func checkUserType(uid: String) -> String {
        var type = String()
            let users = self.database.child(UberConstants.kuser).child(uid)
            users.observeSingleEvent(of: .value) { (snapshot) in
                let data = snapshot.value as? NSDictionary
                let userType = data?[UberConstants.kType] as? String
                type = userType ?? "erro"
            }
        return type
    }
}

