//
//  ContentView.swift
//  WeatherApp
//
//  Created by Robin Hellgren on 16/03/2024.
//

import SwiftUI

struct ContentView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UINavigationController

    func makeUIViewController(
        context: Context
    ) -> UINavigationController {
        UINavigationController(
            rootViewController: OverviewTableViewController())
    }
    
    func updateUIViewController(
        _ uiViewController: UINavigationController,
        context: Context
    ) { }
}

#Preview {
    ContentView()
}
