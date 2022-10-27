//
//  URL+Extensions.swift
//  GoodWeatherRx
//
//  Created by Maxim Bekmetov on 27.10.2022.
//

import Foundation

extension URL {
    static func urlForWeatherAPI(city: String) -> URL? {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&APPID=553e8f06610f80ef3f68120a1e11744f&units=imperial")
    }
}
