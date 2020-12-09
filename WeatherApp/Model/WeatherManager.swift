//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Manpreet Kaur on 2020-11-22.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=c69fb0f06763af5385f0832d99bd6ce4&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
        
    }
    
    func fetchWeather(latitude: CLLocationDegrees ,longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    // Perform networking that fetches live data from openweather map
    func performRequest(with urlString: String)
    {
//                   1.create a URL
        if let url = URL(string: urlString) {
            
            //        2.create a URL Session
            let session = URLSession(configuration: .default)
            
            //        3.Give the Session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                }
                
                if let safeData = data {
//                    let dataString = String(data: safeData, encoding: .utf8)
//                    print(dataString)
                    if let weather = self.parseJSON(safeData) {
//                        let weatherVC = WeatherViewController()
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            //        4.Perform the task
            task.resume()
            
        }
    }
    
    // Parse data into an swift object
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
        let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = (decodedData.weather[0].id)
            let temp = (decodedData.main.temp)
            let name = (decodedData.name)
            
           let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            print(weather.conditionName)
            print(weather.temperatureString)
            return weather
            
        }
        catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    
    
}
