//
//  WeatherResult.swift
//  GoodWeatherRx
//
//  Created by Maxim Bekmetov on 27.10.2022.
//

import Foundation

struct WeatherResult: Decodable {
    let main: Weather
}

struct Weather: Decodable {
    let temp: Double
    let humidity: Double
}

extension WeatherResult {
    static var empty: WeatherResult {
        return WeatherResult(main: Weather(temp: 0.0, humidity: 0.0))
    }
}
