//
//  PassengerViewController.swift
//  UberClone
//
//  Created by Fellipe Ricciardi Chiarello on 7/8/20.
//  Copyright © 2020 fchiarello. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import MapKit

class PassengerViewController: UIViewController, Storyboarded {

    var coordinator: PassengerCoordinator?
    var locationManager = CLLocationManager()
    var userLocation = CLLocationCoordinate2D()
    var uberCalled: Bool = false
    var userData = [ String() : String() ]
    
    let auth = Auth.auth()
    let database = Database.database().reference()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var uberButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUserLocation()
        setupNavigationBar()
    }

    func setupNavigationBar() {
        let button = UIBarButtonItem(title: "logout", style: .plain, target: self, action: #selector(appLogout))
        navigationItem.leftBarButtonItem = button
        navigationItem.title = "UBER"
    }
    
    func setupButton() {
        if !uberCalled {
            uberButton.setTitle("chamar Uber", for: .normal)
            uberButton.backgroundColor = UIColor(red: 4.0/255.0, green: 120.0/255.0, blue: 124/255.0, alpha: 1)
        } else {
            uberButton.setTitle("cancelar", for: .normal)
            uberButton.backgroundColor = .red
        }
    }

    @objc func appLogout() {
        let auth = Auth.auth()
        do {
            try auth.signOut()
            coordinator?.dismiss()
            print("Deslogado")            
        } catch  {
            print("erro ao deslogar")
        }
    }
    @IBAction func callUber(_ sender: Any) {
        if !uberCalled{
            self.uberCalled = true
            prepareForCallUber()
            self.setupButton()
        } else {
            self.uberCalled = false
            self.setupButton()
            cancelUberCall()
        }
    }
}

extension PassengerViewController: CLLocationManagerDelegate {
    
    func setUpUserLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Recupera coordenadas do local atual
        if let coordinates = manager.location?.coordinate {
            self.userLocation = coordinates
            let zone = MKCoordinateRegion(center: coordinates, latitudinalMeters: 200, longitudinalMeters: 200)
            mapView.setRegion( zone, animated: true)
            
            //Exclui anotacoes anteriores
            mapView.removeAnnotations(mapView.annotations)
            
            // Cria pinpoint para o usuario
            let pinPoint = MKPointAnnotation()
            pinPoint.coordinate = coordinates
            pinPoint.title = String()
            mapView.addAnnotation(pinPoint)
        }
    }
    
    func prepareForCallUber() {
        let requisitions = self.database.child(UberConstants.kRequisitions)
        
        requisitions.childByAutoId().setValue(getUserData())
    }
    
    func cancelUberCall() {
        let requisitions = self.database.child(UberConstants.kRequisitions)
        
        let userEmail = self.auth.currentUser?.email ?? String()
        requisitions.queryOrdered(byChild: UberConstants.kEmail).queryEqual(toValue: userEmail).observeSingleEvent(of: .childAdded) { (snapshot) in
            snapshot.ref.removeValue()
        }
    }
    
    func getUserData() -> Dictionary<String, String> {
        let currentUser = self.auth.currentUser
        let email = currentUser?.email
        let uid = currentUser?.uid ?? String()
        let users = database.child(UberConstants.kuser).child(uid)
        
        users.observeSingleEvent(of: .value) { (snapshot) in
            let data = snapshot.value as? NSDictionary
            let name = data![UberConstants.kName] as? String
            
            let latitude = self.userLocation.latitude
            let longitude = self.userLocation.longitude
            
            self.userData = [UberConstants.kEmail : email ?? String(),
                            UberConstants.kName : name ?? String(),
                            UberConstants.kLatitude : String(describing: latitude),
                            UberConstants.kLongitude : String(describing: longitude)]
        }
        return userData
    }
}
