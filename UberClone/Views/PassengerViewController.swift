//
//  PassengerViewController.swift
//  UberClone
//
//  Created by Fellipe Ricciardi Chiarello on 7/8/20.
//  Copyright © 2020 fchiarello. All rights reserved.
//

import UIKit
import FirebaseAuth
import MapKit

class PassengerViewController: UIViewController, Storyboarded {

    var coordinator: PassengerCoordinator?
    var locationManager = CLLocationManager()
    
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
}
