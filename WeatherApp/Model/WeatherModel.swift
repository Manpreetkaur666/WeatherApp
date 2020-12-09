//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Manpreet Kaur on 2020-12-01.
//

import Foundation

struct WeatherModel {
    
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String{
        
        let temp = String(format: "%.1f", temperature)
        return temp
    }
    
    var conditionName: String{
        
        switch conditionId {
        case 200...232:
            return("cloud.bolt")
        case 300...321:
            return("cloud.drizzle")
        case 500...531:
            return("cloud.rain")
        case 600...622:
            return("cloud.snow")
        case 701...781:
            return("cloud.fog")
        case 800:
            return("sun.max")
        case 801...804:
            return("cloud.bolt")
        default:
            return("cloud")
        }
        
        
    }
    
//    func getConditionName(weatherId: Int) -> String{
//
//        //let weatherCondition = "rain"
//
//    }
}
