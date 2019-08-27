//
//  ViewController.swift
//  WeatherOnMap
//
//  Created by Vova SKR on 26/08/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    let initialLocation = CLLocation(latitude: 55.7522200, longitude: 37.6155600)
    let regionRadius: CLLocationDistance = 6000
    var weatherModel: [WeatherAnotation] = []
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        centerMapOnLocation(location: initialLocation)
        
        mapView.register ( WeatherkView.self,
                           forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier )
        
        loadInitialData()
        mapView.addAnnotations(weatherModel)
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
        let decoder = JSONDecoder()
 
        do {
            let decodeData = try decoder.decode(WeatherModel.self, from: optionalData)
            let validWorks = decodeData.weather.compactMap { WeatherAnotation(jsonData: $0) }
            weatherModel.append(contentsOf: validWorks)
            print("Yes")
        } catch {
            print(error.localizedDescription)
        }
    }
}
