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
    
    var userRequests: [DataSnapshot] = []
        
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getRequisitions()
        setupNavigationBar()
        setupTableView()
    }
    
    func setupNavigationBar() {
        let button = UIBarButtonItem(title: UberConstants.kLogout, style: .plain, target: self, action: #selector(appLogout))
        navigationItem.leftBarButtonItem = button
        navigationItem.title = UberConstants.kRequests
    }
    
    @objc func appLogout() {
        let auth = Auth.auth()
        do {
            try auth.signOut()
            coordinator?.dismiss()
        } catch  {
            print("erro ao deslogar")
        }
    }
    
    func setupTableView() {
        self.tableView.register(UINib(nibName: UberConstants.kDriverCellClass, bundle: Bundle(for: DriverTableViewCell.self)), forCellReuseIdentifier: UberConstants.kCellId)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
    }
}

extension DriverViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userRequests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UberConstants.kCellId, for: indexPath) as! DriverTableViewCell
        let snapshot = self.userRequests[indexPath.row]
        
        if let data = snapshot.value as? [String : Any] {
            cell.titleLabel.text = data[UberConstants.kEmail] as? String
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension DriverViewController {
    func getRequisitions() {
        let database = Database.database().reference()
        let requisitions = database.child(UberConstants.kRequisitions)
        
        requisitions.observe(.childAdded) { (snapshot) in
            self.userRequests.append(snapshot)
            self.tableView.reloadData()
        }
    }
}
