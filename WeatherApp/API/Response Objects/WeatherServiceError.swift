//
//  WeatherServiceError.swift
//  API
//
//  Created by Robin Hellgren on 16/03/2024.
//

import Foundation

public enum WeatherServiceError: Error {
    case urlParsingFailed
    case httpError(Error)
    case failedToMatchHTTPStatusCode
    case decodingError(Error)
}
