//
//  WeatherModels.swift
//  HourlyWTrackerSasidurka
//
//  Created by Sasidurka on 2024-12-16.
//

import Foundation

struct WeatherResponse: Codable {
    let list: [WeatherData]
}

struct WeatherData: Codable {
    let dt: Int
    let main: MainInfo
    let weather: [WeatherDetail]
}

struct MainInfo: Codable {
    let temp: Double
}

struct WeatherDetail: Codable {
    let description: String
    let icon: String
}

