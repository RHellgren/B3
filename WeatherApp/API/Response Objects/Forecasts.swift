//
//  Forecasts.swift
//  API
//
//  Created by Robin Hellgren on 16/03/2024.
//

import Foundation

public struct Forecasts: Codable {
    public let list: [Forecast]
    
    public struct Forecast: Codable {
        public let date: Date
        public let weather: [Weather]
        public let main: Main
        public let wind: Wind
        
        enum CodingKeys: String, CodingKey {
            case date = "dt"
            case weather
            case main
            case wind
        }

        public struct Weather: Codable {
            public let main: String
            public let description: String
            public let icon: String
        }
        
        public struct Main: Codable {
            public let temperature: Float
            public let feelLike: Float
            public let humidity: Float
            
            enum CodingKeys: String, CodingKey {
                case temperature = "temp"
                case feelLike = "feels_like"
                case humidity
            }
        }
        
        public struct Wind: Codable {
            public let speed: Float
        }
    }
}
