//
//  WeatherManager.swift
//  Clima
//
//  Created by Furkan Armakan on 23.05.2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=f687c05ea634901e8fe535d5e86aae8b&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
        
    }
    
    func fetchWeather(latitude: CLLocationDegrees , longitute: CLLocationDegrees ){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitute)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        
        // 1) Create a url we have a string represantion a url
        if let url = URL(string: urlString) {
            // it doesnt end up be a nill
            
            // 2) Create a url Session
            let session = URLSession(configuration: .default)
            
            // 3) Give a TASK for URLSession
            
            
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            // 4)
            task.resume()
            
        }
        
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedDate = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedDate.weather[0].id
            let temp = decodedDate.main.temp
            let name = decodedDate.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
            
            
            
            
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
}



