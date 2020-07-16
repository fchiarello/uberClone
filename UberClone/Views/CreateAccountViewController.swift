//
//  CreateAccountViewController.swift
//  UberClone
//
//  Created by Fellipe Ricciardi Chiarello on 6/3/20.
//  Copyright © 2020 fchiarello. All rights reserved.
//

import UIKit
import FirebaseAuth

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
        if let email = self.email.text{
            if self.name.text != nil{
                if let password = self.password.text{
                    if self.confirmPassword.text != nil{
                        auth.createUser(withEmail: email, password: password) { (user, error) in
                            if error == nil {
                                self.coordinator?.passenger()
                            }else {
                                print("Erro no cadastro")
                            }
                        }
                    }
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
