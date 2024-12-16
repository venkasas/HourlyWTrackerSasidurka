//
//  ContentView.swift
//  HourlyWTrackerSasidurka
//
//  Created by Sasidurka on 2024-12-16.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter city name", text: $viewModel.city)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("Search") {
                    Task {
                        await viewModel.fetchWeather()
                    }
                }
                .padding()

                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    List(viewModel.weatherData, id: \.dt) { weather in
                        WeatherRowView(weather: weather)
                    }
                }
            }
            .navigationTitle("Hourly Weather")
            .padding()
        }
    }
}

struct WeatherRowView: View {
    let weather: WeatherData

    var body: some View {
        HStack {
            // Format and display the forecast time
            Text(formatDate(weather.dt))
                .frame(width: 100, alignment: .leading)

            Spacer()

            // Display the temperature
            Text("\(Int(weather.main.temp))°C")
                .frame(width: 50, alignment: .center)

            Spacer()

            // Display the weather icon using the helper function
            Image(systemName: weatherIcon(for: weather.weather.first?.icon ?? ""))
                .frame(width: 50, alignment: .trailing)

        }
    }

    // Function to format the timestamp into a human-readable time
    private func formatDate(_ timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "h a" // Format as "5 PM"
        return formatter.string(from: date)
    }

    func weatherIcon(for code: String) -> String {
        switch code {
        case "01d": return "sun.max.fill"
        case "01n": return "moon.fill"
        case "02d": return "cloud.sun.fill"
        case "02n": return "cloud.moon.fill"
        case "03d", "03n": return "cloud.fill"
        case "04d", "04n": return "smoke.fill"
        case "09d", "09n": return "cloud.rain.fill"
        case "10d": return "cloud.sun.rain.fill"
        case "10n": return "cloud.moon.rain.fill"
        case "11d", "11n": return "cloud.bolt.fill"
        case "13d", "13n": return "snow"
        case "50d", "50n": return "cloud.fog.fill"
        default: return "cloud.fill"
        }
    }
}
