//
//  PassengerViewController.swift
//  UberClone
//
//  Created by Fellipe Ricciardi Chiarello on 7/8/20.
//  Copyright © 2020 fchiarello. All rights reserved.
//

import UIKit

class PassengerViewController: UIViewController, Storyboarded {

    var coordinator: PassengerCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        // Do any additional setup after loading the view.
    }

    func setupNavigationBar() {
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 45))
        view.addSubview(navBar)
        let navItem = UINavigationItem(title: "UBER")
        let button = UIBarButtonItem(title: "logout", style: .plain, target: nil, action: #selector(appLogout))
        navItem.rightBarButtonItem = button
        navBar.setItems([navItem], animated: false)
    }
    
    @objc func appLogout() {
        print("logout efetuado")
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
