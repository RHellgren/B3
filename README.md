# B3
> Build an small weather application.

[![5.9.2][swift-image]][swift-url]
[![License][license-image]][license-url]
[![iOS](https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat)](https://developer.apple.com/documentation/)

Uses the OpenWeatherMap API to fetch and display current weather data for a predefined set of cities. Tapping a cell opens a detailed view showing additional weather information as well as the forecast for the upcoming 24 hours. Supports dark and light mode.

## Requirements

- iOS 17.2+
- XCode 15.1+

## Setup

The app needs a key to the OpenWeatherMap API ([https://openweathermap.org/api](https://openweathermap.org/api)) to be defined in the `Config.plist` file inside the `API` module. It uses no third party dependencies.

## Meta

Distributed under the MIT license. See ``LICENSE`` for more information.

[swift-image]:https://img.shields.io/badge/swift-5.0-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: https://opensource.org/licenses/MIT