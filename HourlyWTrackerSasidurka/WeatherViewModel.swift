//
//  WeatherViewModel.swift
//  HourlyWTrackerSasidurka
//
//  Created by Sasidurka on 2024-12-16.
//

import Foundation
import SwiftUI
import CoreLocation

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var city: String = ""
    @Published var weatherData: [WeatherData] = []
    @Published var errorMessage: String?

    private let service = WeatherService()
    private let geocoder = CLGeocoder()

    func fetchWeather() async {
        do {
            
            let location = try await getCoordinates(for: city)
            
            
            let response = try await service.fetchWeather(lat: location.latitude, lon: location.longitude)
            weatherData = response.list
            errorMessage = nil 
        } catch {
            errorMessage = "Failed to fetch weather data. Please check the city name or try again."
        }
    }

    private func getCoordinates(for city: String) async throws -> CLLocationCoordinate2D {
        let placemarks = try await geocoder.geocodeAddressString(city)
        guard let location = placemarks.first?.location else {
            throw URLError(.badURL)
        }
        print("Geocoded city: \(city), Location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
        return location.coordinate
    }

}

