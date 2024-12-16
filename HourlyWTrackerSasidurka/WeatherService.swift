//
//  WeatherService.swift
//  HourlyWTrackerSasidurka
//
//  Created by Sasidurka on 2024-12-16.
//

import Foundation

class WeatherService {
    private let apiKey = "158dd124ddb76ae87f37d77ee629495b"

    func fetchWeather(lat: Double, lon: Double) async throws -> WeatherResponse {
        // Construct the correct API URL
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric"
        print("API URL: \(urlString)") // Debug log to ensure URL is correct
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        // Perform the network call
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Debug log to check response
        if let httpResponse = response as? HTTPURLResponse {
            print("HTTP Status: \(httpResponse.statusCode)")
        }
        
        // Decode JSON response into WeatherResponse model
        return try JSONDecoder().decode(WeatherResponse.self, from: data)
    }
}
//https://api.openweathermap.org/data/2.5/forecast?q=Oakville&appid=158dd124ddb76ae87f37d77ee629495b&units=metric//
