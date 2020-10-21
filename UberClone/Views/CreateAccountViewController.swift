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
    
    
    @IBAction func createButton(_ sender: Any) {
        let emptyField = checkForEmptyFields()
        if emptyField == "" {
            createFirebaseUser()
        }else {
            print("o campo \(emptyField), não foi preenchido")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func checkForEmptyFields() -> String {
        if (self.email.text?.isEmpty)! {
            return "e-mail"
        } else if (self.name.text?.isEmpty)! {
            return "nome completo"
        } else if (self.password.text?.isEmpty)! {
            return "senha"
        }else if (self.confirmPassword.text?.isEmpty)! {
            return "confirme senha"
        }
        return ""
    }
    
    func createFirebaseUser() {
        let auth = Auth.auth()
        let fields = checkingFieldsForNewUser()
        let name = self.name.text ?? String()
        
        if !fields {
            auth.createUser(withEmail: self.email.text ?? String(), password: self.password.text ?? String()) { (user, error) in
                if error == nil {
                    if user != nil {
                        let database = Database.database().reference()
                        let users = database.child("usuarios")
                        let userType = self.getUserType()
                        let userData = ["email" : user?.user.email,
                                        "nome" : name,
                                        "tipo" : userType]
                        users.child(user?.user.uid ?? String()).setValue(userData)
                        self.coordinator?.passenger()
                    }
                } else {
                    print(error?.localizedDescription)
                }
            }
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
            return "passageiro"
        } else {
            return "motorista"
        }
    }
}
