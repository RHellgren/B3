//
//  OverviewViewModel.swift
//  WeatherApp
//
//  Created by Robin Hellgren on 16/03/2024.
//

import API
import Foundation

final class City {
    let name: String
    let latitude: Double
    let longitude: Double
    var forecasts: Forecasts?
    
    init(
        name: String,
        latitude: Double,
        longitude: Double
    ) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.forecasts = nil
    }
}

final class OverviewViewModel {
    
    private let service = WeatherService()
    private let didUpdateCallback: (() -> Void)?
    private let cities: [City]
    
    var cellViewModels: [OverviewCellViewModel] = []
    var detailModels: [DetailsViewModel] = []
    
    init(
        didUpdateCallback: (() -> Void)?,
        cities: [City] = [
            City(name: "Stockholm", latitude: 59.334591, longitude: 18.063240),
            City(name: "London", latitude: 51.509865, longitude: -0.118092),
            City(name: "New York", latitude: 40.730610, longitude: -73.935242),
            City(name: "Sydney", latitude: -33.865143, longitude: 151.209900),
            City(name: "Hong Kong", latitude: 22.302711, longitude: 114.177216),
        ]
    ) {
        self.didUpdateCallback = didUpdateCallback
        self.cities = cities
        updateCellViewModels()
        updateDetailModels()
    }

    func fetchData() async throws {
        for city in cities {
            let weatherData = try await service.fetch(
                latitude: city.latitude,
                longitude: city.longitude)
            city.forecasts = weatherData
            updateCellViewModels()
            updateDetailModels()
            didUpdateCallback?()
        }
    }
    
    private func updateCellViewModels() {
        cellViewModels = cities.compactMap { city in
            OverviewCellViewModel(
                cityName: city.name,
                temperature: city.forecasts?.temperature)
        }
    }
    
    private func updateDetailModels() {
        detailModels = cities.compactMap { city in
            DetailsViewModel(
                cityName: city.name,
                currentTemperature: city.forecasts?.temperature,
                feelsLikeTemperature: city.forecasts?.feelsLikeTemperature,
                windSpeed: city.forecasts?.windSpeed,
                humidity: city.forecasts?.humidity,
                todaysForecasts: city.forecasts?.list
                    .filter { forecast in Calendar.current.isDateInToday(forecast.date) }
                    .detailsViewModelForecasts() ?? [],
                tomorrowsForecasts: city.forecasts?.list
                    .filter { forecast in Calendar.current.isDateInTomorrow(forecast.date) }
                    .detailsViewModelForecasts() ?? []
            )
        }
    }
}

fileprivate extension Forecasts {
    var temperature: Float? {
        list.first?.main.temperature
    }
    
    var feelsLikeTemperature: Float? {
        list.first?.main.feelLike
    }
    
    var windSpeed: Float? {
        list.first?.wind.speed
    }
    
    var humidity: Int? {
        list.first?.main.humidity
    }
}

fileprivate extension Array where Element == Forecasts.Forecast {
    func detailsViewModelForecasts() -> [DetailsViewModel.Forecast] {
        self.compactMap { forecast in
            guard let icon = forecast.weather.first?.icon else { return nil }
            return DetailsViewModel.Forecast(
                time: forecast.date,
                iconURL: URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png"),
                temperature: forecast.main.temperature
            )
        }
    }
}
