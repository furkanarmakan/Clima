//
//  WeatherData.swift
//  Clima
//
//  Created by Furkan Armakan on 24.05.2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let coord : Coord
}


struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}

struct Coord: Codable {
    let lon : Double
    let lat: Float
}

// weather[0].description
