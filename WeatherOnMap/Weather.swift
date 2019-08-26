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
    var coordinate: CLLocationCoordinate2D
    
   init?(jsonData: Weather) {
        self.title = jsonData.city.name
        self.subtitle = String(jsonData.main.temp)
        self.coordinate = CLLocationCoordinate2D(latitude: jsonData.city.coord.lat,
                                                 longitude: jsonData.city.coord.lon)
    
    }
}

struct WeatherModel: Codable {
    let weather: [Weather]
}

struct Weather: Codable {
    var city: City
    var main: TemperatureData
    var weather: [WeatherData]
}

struct City: Codable {
    let name: String
    let coord: CoordData
    
}

struct CoordData: Codable {
    let lon: Double
    let lat: Double
}

struct TemperatureData: Codable {
    let temp: Double
}

struct WeatherData: Codable {
    let id: Int
}



extension CLLocationCoordinate2D: Codable {
    public enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }
    
    public init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try values.decode(Double.self, forKey: .latitude)
        longitude = try values.decode(Double.self, forKey: .longitude)
    }
}



