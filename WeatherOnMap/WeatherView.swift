//
//  WeatherView.swift
//  WeatherOnMap
//
//  Created by Vova SKR on 26/08/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import Foundation
import MapKit

class WeatherkView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let weather = newValue as? WeatherAnotation else { return }
            canShowCallout = true
            calloutOffset = CGPoint(x: 0, y: 5)
            let weatherImage = UIImage(named: weather.image ?? "refresh")
            leftCalloutAccessoryView = UIImageView(image: weatherImage)
            image = weatherImage
            clusteringIdentifier = "AnnotationViewIdentifier"
            
        }
    }
}
