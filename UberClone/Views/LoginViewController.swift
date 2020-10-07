//
//  LoginViewController.swift
//  UberClone
//
//  Created by Fellipe Ricciardi Chiarello on 6/3/20.
//  Copyright © 2020 fchiarello. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, Storyboarded {
    
    var coordinator: LoginCoordinator?
    
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
        self.email.text = "fellipe.passageiro@gmail.com"
        self.password.text = "123456"
        // Do any additional setup after loading the view.
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
        let auth = Auth.auth()
        
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
}
