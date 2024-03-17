//
//  Collection+Extensions.swift
//  WeatherApp
//
//  Created by Robin Hellgren on 17/03/2024.
//

import Foundation

/// Source: https://stackoverflow.com/a/30593673
extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
