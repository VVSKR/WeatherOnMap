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

extension ViewController: MKMapViewDelegate {
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        guard let annotation = annotation as? WeatherAnotation else { return nil }
//        let identifier = "marker"
//        var view: MKMarkerAnnotationView
//
//        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
//            as? MKMarkerAnnotationView {
//            dequeuedView.annotation = annotation
//            view = dequeuedView
//        } else {
//            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//            view.canShowCallout = true
//            view.calloutOffset = CGPoint(x: 0, y: 5)
////            view.image = UIImage(named: annotation.image ?? "refresh")
//            let image = UIImageView(frame: CGRect(origin: CGPoint.zero,
//            size: CGSize(width: 30, height: 30)))
//            image.image = UIImage(named: "sanny")
//            view.rightCalloutAccessoryView = image
//        }
//        return view
//    }
}
