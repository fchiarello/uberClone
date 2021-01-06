//
//  CreateAccountViewController.swift
//  UberClone
//
//  Created by Fellipe Ricciardi Chiarello on 6/3/20.
//  Copyright © 2020 fchiarello. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CreateAccountViewController: UIViewController, Storyboarded {
    
    var coordinator: MainCoordinator?
    
    //MARK: - Outlets / Actions
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var switchType: UISwitch!
    
    let auth = Auth.auth()
    
    @IBAction func createButton(_ sender: Any) {
            createFirebaseUser()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.email.text = "motorista2@gmail.com"
        self.name.text = "motorista2"
        self.password.text = "123456"
        self.confirmPassword.text = "123456"
        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func createFirebaseUser() {
        let fields = checkingFieldsForNewUser()
        let name = self.name.text ?? String()
        
        if !fields {
            self.auth.createUser(withEmail: self.email.text ?? String(), password: self.password.text ?? String()) { (user, error) in
                if error == nil {
                    if user != nil {
                        let database = Database.database().reference()
                        let users = database.child("usuarios")
                        let userType = self.getUserType()
                        let userData = ["email" : user?.user.email,
                                        "nome" : name,
                                        "tipo" : userType]
                        users.child(user?.user.uid ?? String()).setValue(userData)
//                        if userType == UberConstants.kDriver{
//                            self.coordinator?.driver()
//                        } else {
//                            self.coordinator?.passenger()
//                        }
                    }
                } else {
                    print(error?.localizedDescription ?? "erro")
                }
            }
        } else {
            //tratar erro
            print("Preencher todos os campos.")
        }
    }
    
    func checkingFieldsForNewUser() -> Bool {
        if let email = self.email.text, let name = self.name.text, let password = self.password.text, let confirm = confirmPassword.text, email.isEmpty || name.isEmpty || password.isEmpty || confirm.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    func getUserType() -> String {
        if switchType.isOn {
            return UberConstants.kPassenger
        } else {
            return UberConstants.kDriver
        }
    }
}
