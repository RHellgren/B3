//
//  DetailsViewModel.swift
//  WeatherApp
//
//  Created by Robin Hellgren on 17/03/2024.
//

import Foundation

struct DetailsViewModel {
    let cityName: String
    let currentTemperature: Float?
    let feelsLikeTemperature: Float?
    let windSpeed: Float?
    let humidity: Int?
    let todaysForecasts: [Forecast]
    let tomorrowsForecasts: [Forecast]
    
    struct Forecast {
        let time: Date
        let iconURL: URL?
        let temperature: Float
    }
    
    var currentTemperatureString: String? {
        guard let currentTemperature else { return nil }
        return String(localized: "\(currentTemperature) °C")
    }
    
    var feelsLikeTemperatureString: String? {
        guard let feelsLikeTemperature else { return nil }
        return String(localized: "\(feelsLikeTemperature) °C")
    }
    
    var windSpeedString: String? {
        guard let windSpeed else { return nil }
        return String(localized: "\(windSpeed) m/s")
    }
    
    var humidityString: String? {
        guard let humidity else { return nil }
        return String(localized: "\(humidity)%")
    }
    
    var hasForecasts: Bool {
        !(todaysForecasts.isEmpty && tomorrowsForecasts.isEmpty)
    }
}
