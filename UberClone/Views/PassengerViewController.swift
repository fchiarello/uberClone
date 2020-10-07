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
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUserLocation()
        setupNavigationBar()
        // Do any additional setup after loading the view.
    }

    func setupNavigationBar() {
        let button = UIBarButtonItem(title: "logout", style: .plain, target: self, action: #selector(appLogout))
        navigationItem.leftBarButtonItem = button
        navigationItem.title = "UBER"
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
        print("CLICADO!!!!!!!!")
        prepareForCallUber()
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
            pinPoint.title = ""
            mapView.addAnnotation(pinPoint)
        }
    }
    
    func prepareForCallUber() {
        let database = Database.database().reference()
        let requisitions = database.child(UberConstants.kRequisitions)
        
        requisitions.childByAutoId().setValue(getUserData())
    }
    
    func getUserData() -> Dictionary<String, String> {
        let auth = Auth.auth()
        let email = auth.currentUser?.email
        let name = auth.currentUser?.displayName
        let latitude = self.userLocation.latitude
        let longitude = self.userLocation.longitude
        
        let userData = [UberConstants.kEmail : email ?? "",
                        UberConstants.kName : name ?? "Fellipe Passageiro",
                        UberConstants.kLatitude : "\(latitude)",
                        UberConstants.kLongitude : "\(longitude)"]
        
        return userData
    }
}
