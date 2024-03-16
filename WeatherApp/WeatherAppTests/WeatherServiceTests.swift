//
//  WeatherServiceTests.swift
//  WeatherAppTests
//
//  Created by Robin Hellgren on 16/03/2024.
//

@testable import API

import XCTest

final class WeatherServiceTests: XCTestCase {
    
    var sut: WeatherService!
    
    override func setUp() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        sut = WeatherService(session: urlSession)
    }
    
    func testFetchStockholm() async throws {
        let latitude = 59.334591
        let longitude = 18.063240

        MockURLProtocol.requestHandler = { request in
            let apiURL = URL(string: "https://api.openweathermap.org/data/2.5/forecast")!
            let response = HTTPURLResponse(url: apiURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
            let mockData = MockData().readJSONFile(fileName: "Forecasts_mock")

            return (response, mockData)
        }
        
        let response = try await sut.fetch(
            latitude: latitude,
            longitude: longitude
        )
        
        XCTAssertEqual(response.list.count, 9)
        
        let forecast = try XCTUnwrap(response.list[0])
        XCTAssertEqual(forecast.date, Date(timeIntervalSince1970: TimeInterval(1710601200)))
        XCTAssertEqual(forecast.main.temperature, 2.47)
        XCTAssertEqual(forecast.main.feelLike, 1.23)
        XCTAssertEqual(forecast.main.humidity, 94)
        XCTAssertEqual(forecast.wind.speed, 1.39)
    }
}
