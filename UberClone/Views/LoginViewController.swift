//
//  LoginViewController.swift
//  UberClone
//
//  Created by Fellipe Ricciardi Chiarello on 6/3/20.
//  Copyright © 2020 fchiarello. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController, Storyboarded {
    
    var coordinator: LoginCoordinator?
    let auth = Auth.auth()

    //MARK: - Outlets / Actions
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func loginButton(_ sender: Any) {
        let emptyField = self.checkForEmptyFields()
        
        if emptyField == "" {
            self.authUser()
        }else {
            print("O campo \(emptyField), não foi preenchido!")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.email.text = "motorista@gmail.com"
        self.password.text = "123456"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func checkForEmptyFields() -> String {
        if (self.email.text?.isEmpty)! {
            return "e-mail"
        } else if (self.password.text?.isEmpty)! {
            return "senha"
        }
        return ""
    }
    
    func authUser() {
        if let email = self.email.text{
            if let password = self.password.text{
                auth.signIn(withEmail: email, password: password) { (user, error) in
                    if error == nil {
                        
                    }else{
                        print("Erro ao logar")
                    }
                }
            }
        }
    }
    
    func getUserType() -> String {
        let ref = Database.database().reference()
        var tipo = String()
        if let id = self.auth.currentUser?.uid {
            ref.child("usuarios").child(id).observeSingleEvent(of: .value) { (snap) in
                let value = snap.value as? NSDictionary
                tipo = String(describing: value?["tipo"])
            }
        }
        return tipo
    }
}

