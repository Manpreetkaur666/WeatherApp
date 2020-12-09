//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Manpreet Kaur on 2020-11-23.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
}
