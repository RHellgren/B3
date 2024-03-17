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
    var temperature: Float?
    
    init(
        name: String,
        latitude: Double,
        longitude: Double
    ) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.temperature = nil
    }
}

final class OverviewViewModel {
    
    private let service = WeatherService()
    private let didUpdateCallback: (() -> Void)?
    private let cities: [City]
    
    var cellViewModels: [OverviewCellViewModel] = []
    
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
    }

    func fetchData() async throws {
        for city in cities {
            let weatherData = try await service.fetch(
                latitude: city.latitude,
                longitude: city.longitude)
            city.temperature = weatherData.list.first?.main.temperature
            updateCellViewModels()
            didUpdateCallback?()
        }
    }
    
    private func updateCellViewModels() {
        cellViewModels = cities.compactMap { city in
            OverviewCellViewModel(
                cityName: city.name,
                temperature: city.temperature)
        }
    }
}
