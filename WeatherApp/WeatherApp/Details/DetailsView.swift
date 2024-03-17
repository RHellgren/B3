//
//  DetailsView.swift
//  WeatherApp
//
//  Created by Robin Hellgren on 17/03/2024.
//

import SwiftUI

struct DetailsView: View {
    @Environment(\.dismiss) var dismiss

    let model: DetailsViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: Constants.spacing) {
                    weatherDetailViews()
                    
                    if model.hasForecasts {
                        forecastViews()
                    }
                    
                    Spacer()
                }
            }
            .navigationTitle(model.cityName)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Constants.CloseButton.image
                            .tint(Constants.CloseButton.tint)
                    }
                }
            })
        }
    }
    
    @ViewBuilder
    private func weatherDetailViews() -> some View {
        DetailsRowView(
            title: Constants.currentTemperatureTitle,
            value: model.currentTemperatureString)
        
        DetailsRowView(
            title: Constants.feelsLikeTitle,
            value: model.feelsLikeTemperatureString)
        
        DetailsRowView(
            title: Constants.windSpeedTitle,
            value: model.windSpeedString)
        
        DetailsRowView(
            title: Constants.humidityTitle,
            value: model.humidityString)
    }
    
    @ViewBuilder
    private func forecastViews() -> some View {
        HStack {
            Text(Constants.Forecasts.title)
                .font(Constants.Forecasts.titleFont)
                .padding(.horizontal)
                .underline()
            Spacer()
        }
        .padding(.top, Constants.Forecasts.titlePadding)
        
        if !model.todaysForecasts.isEmpty {
            DetailsForecastView(
                title: Constants.Forecasts.todaytitle,
                forecasts: model.todaysForecasts)
        }
        
        if !model.tomorrowsForecasts.isEmpty {
            DetailsForecastView(
                title: Constants.Forecasts.tomorrowTitle,
                forecasts: model.tomorrowsForecasts)
        }
    }
}

extension DetailsView {
    struct Constants {
        static let spacing: CGFloat = 6
        static let titleFont: Font = .largeTitle
        static let currentTemperatureTitle = String(localized: "Current temperature")
        static let feelsLikeTitle = String(localized: "Feels like")
        static let windSpeedTitle = String(localized: "Wind speed")
        static let humidityTitle = String(localized: "Humidity")
        
        struct CloseButton {
            static let image = Image(systemName: "xmark")
            static let tint = Color("IconTint")
        }

        struct Forecasts {
            static let title = String(localized: "Forecast")
            static let titleFont: Font = .title2
            static let titlePadding: CGFloat = 20
            static let todaytitle = String(localized: "Today")
            static let tomorrowTitle = String(localized: "Tomorrow")
        }
    }
}

#Preview {
    DetailsView(
        model: DetailsViewModel(
            cityName: "Stockholm",
            currentTemperature: 10.50,
            feelsLikeTemperature: 9.40,
            windSpeed: 1.32,
            humidity: 23,
            todaysForecasts: [
                DetailsViewModel.Forecast(
                    time: Date.now.addingTimeInterval(60*60*3),
                    iconURL: URL(string: ""),
                    temperature: 12.50)],
            tomorrowsForecasts: [
                DetailsViewModel.Forecast(
                    time: Date.now.addingTimeInterval(60*60*6),
                    iconURL: URL(string: ""),
                    temperature: 15.12),
                DetailsViewModel.Forecast(
                    time: Date.now.addingTimeInterval(60*60*9),
                    iconURL: URL(string: ""),
                    temperature: 11.21)
            ]
        )
    )
}

#Preview {
    DetailsView(
        model: DetailsViewModel(
            cityName: "Stockholm",
            currentTemperature: nil,
            feelsLikeTemperature: nil,
            windSpeed: nil,
            humidity: nil,
            todaysForecasts: [],
            tomorrowsForecasts: []
        )
    )
}
