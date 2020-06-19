//
//  ViewController.swift
//  UberClone
//
//  Created by Fellipe Ricciardi Chiarello on 6/2/20.
//  Copyright © 2020 fchiarello. All rights reserved.
//

import UIKit

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
    }


}

