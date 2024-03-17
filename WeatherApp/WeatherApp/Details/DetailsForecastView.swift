//
//  DetailsForecastView.swift
//  WeatherApp
//
//  Created by Robin Hellgren on 17/03/2024.
//

import SwiftUI

struct DetailsForecastView: View {
    let title: String
    let forecasts: [DetailsViewModel.Forecast]
    
    var body: some View {
        HStack {
            Text(title)
                .font(Constants.titleFont)
                .italic()
                .padding(.horizontal)
                .padding(.top, Constants.titlePadding)
            Spacer()
        }
        ForEach(forecasts, id: \.time) { forecast in
            HStack(spacing: Constants.forecastSpacing) {
                Text(forecast.time, style: .time)
                    .italic()
                AsyncImage(
                    url: forecast.iconURL,
                    content: { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(
                                maxWidth: Constants.iconSize,
                                maxHeight: Constants.iconSize
                            )
                    },
                    placeholder: {
                        ProgressView()
                    })
                Text(String(localized: "\(forecast.temperature) °C"))
                Spacer()
            }
            .padding(.leading, Constants.forecastPadding)
            .accessibilityElement(children: .combine)
        }
    }
}

extension DetailsForecastView {
    struct Constants {
        static let titlePadding: CGFloat = 12
        static let titleFont: Font = .subheadline
        static let iconSize: CGFloat = 20
        static let forecastSpacing: CGFloat = 6
        static let forecastPadding: CGFloat = 40
    }
}

#Preview {
    Group {
        DetailsForecastView(
            title: "Today",
            forecasts: [
                DetailsViewModel.Forecast(
                    time: Date.now.addingTimeInterval(60*60*3),
                    iconURL: URL(string: ""),
                    temperature: 12.50)])
        
        DetailsForecastView(
            title: "Tomorrow",
            forecasts: [
                DetailsViewModel.Forecast(
                    time: Date.now.addingTimeInterval(60*60*6),
                    iconURL: URL(string: ""),
                    temperature: 15.12),
                DetailsViewModel.Forecast(
                    time: Date.now.addingTimeInterval(60*60*9),
                    iconURL: URL(string: ""),
                    temperature: 11.21)
            ])
        
        DetailsForecastView(
            title: "Tomorrow",
            forecasts: [])
    }
}
