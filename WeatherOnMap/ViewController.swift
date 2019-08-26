//
//  ViewController.swift
//  WeatherOnMap
//
//  Created by Vova SKR on 26/08/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController {
    
    let initialLocation = CLLocation(latitude: 55.7522200, longitude: 37.6155600)
    let regionRadius: CLLocationDistance = 3000
    var weatherModel: Weather?
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerMapOnLocation(location: initialLocation)
        loadInitialData()
        
        //        mapView.addAnnotation()
    }
    
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius,
                                                  longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func loadInitialData() {
        guard let fileName = Bundle.main.path(forResource: "weather", ofType: "json")
            else { return }
       
        let optionalData = try! Data(contentsOf: URL(fileURLWithPath: fileName))
        let str = String(decoding: optionalData, as: UTF8.self)
        let decoder = JSONDecoder()
 
        do {
            let decodeData = try decoder.decode(WeatherModel.self, from: optionalData)
            print("Yes")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    
    
}
