//
//  MockData.swift
//  WeatherAppTests
//
//  Created by Robin Hellgren on 16/03/2024.
//

import Foundation

final class MockData {
    
    func readJSONFile(
        fileName: String
    ) -> Data {
        do {
            let url = Bundle.main.url(forResource: fileName, withExtension: "json")!
            return try! Data(contentsOf: url)
        }
    }
}
