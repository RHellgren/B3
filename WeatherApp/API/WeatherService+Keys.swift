//
//  WeatherService+Keys.swift
//  API
//
//  Created by Robin Hellgren on 16/03/2024.
//

import Foundation

extension WeatherService {
    internal var apiKey: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "Config", ofType: "plist"),
                  let plist = NSDictionary(contentsOfFile: filePath),
                  let key = plist.object(forKey: "API_KEY") as? String
            else {
                fatalError("Failed to fetch API key.")
            }
            
            return key.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
}
