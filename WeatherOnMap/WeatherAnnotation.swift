//
//  WeatherModel.swift
//  WeatherOnMap
//
//  Created by Vova SKR on 26/08/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import Foundation
import MapKit

class WeatherAnotation: NSObject, MKAnnotation {
    
    var title: String?
    var subtitle: String?
    var imageId: Int?
    var coordinate: CLLocationCoordinate2D
    
    init?(jsonData: Weather) {
        self.title = jsonData.city.name
        self.subtitle = "Temp: " + String(Int(jsonData.main.temp - 273)) + "℃"
        self.imageId = jsonData.weather[0].id
        self.coordinate = CLLocationCoordinate2D(latitude: jsonData.city.coord.lat,
                                                 longitude: jsonData.city.coord.lon)
    }
    
    var image: String? {
        guard let id = imageId else { return nil }
        return updateIcon(condition: id)
    }
}





