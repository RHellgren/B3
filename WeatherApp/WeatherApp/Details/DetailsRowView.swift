//
//  DetailsRowView.swift
//  WeatherApp
//
//  Created by Robin Hellgren on 17/03/2024.
//

import SwiftUI

struct DetailsRowView: View {
    let title: String
    let value: String?
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            if let value {
                Text(value)
            } else {
                Text(String(localized: "Unknown"))
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    Group {
        DetailsRowView(
            title: "Current temperature",
            value: "12.40 °C")
        
        DetailsRowView(
            title: "Current temperature",
            value: nil)
        
    }
}
