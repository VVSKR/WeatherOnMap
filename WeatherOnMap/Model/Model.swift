//
//  Model.swift
//  WeatherOnMap
//
//  Created by Vova SKR on 26/08/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import Foundation

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


func updateIcon (condition: Int) -> String {
    switch condition {
    case 0...300, 772...799, 900...903, 905...1000 :
        return "storm"
        
    case 301...600 :
        return "rain"
        
    case 601...700, 903 :
        return "snow"
        
    case 701...771 :
        return "nimbostratus"
        
    case 800, 904 :
        return "sunny"
        
    case 801...804 :
        return "cloudy"
        
    default :
        return "refresh"
    }
}
