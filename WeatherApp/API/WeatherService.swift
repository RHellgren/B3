//
//  WeatherService.swift
//  API
//
//  Created by Robin Hellgren on 16/03/2024.
//

import Foundation

public final class WeatherService {
    
    private let session: URLSession
    private var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }()

    public init(
        session: URLSession = .shared
    ) {
        self.session = session
    }

    public func fetch(
        latitude: Double,
        longitude: Double
    ) async throws -> Forecasts {
        guard let request = createRequest(latitude: latitude, longitude: longitude) else {
            throw WeatherServiceError.urlParsingFailed
        }
                
        let (data, response) = try await session.data(for: request)
        
        if let httpStatusError = self.httpStatusError(response: response) {
            throw httpStatusError
        }

        do {
            let responseObject = try decoder.decode(Forecasts.self, from: data)
            return responseObject
        } catch let error {
            throw WeatherServiceError.decodingError(error)
        }
    }
    
    private func createRequest(
        latitude: Double,
        longitude: Double
    ) -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openweathermap.org"
        components.path = "/data/2.5/forecast"

        components.queryItems = [
            URLQueryItem(name: "lat", value: "\(latitude)"),
            URLQueryItem(name: "lon", value: "\(longitude)"),
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "cnt", value: "9")
        ]

        guard let url = components.url else {
            return nil
        }
        
        return URLRequest(url: url)
    }
    
    private func httpStatusError(
        response: URLResponse?
    ) -> WeatherServiceError? {
        if let httpResponse = response as? HTTPURLResponse,
            let status = httpResponse.status {
            switch status {
            case .ok:
                return nil

            default:
                return .httpError(status)
            }
        } else {
            return .failedToMatchHTTPStatusCode
        }
    }
}
