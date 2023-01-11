//
//  URL+Ex.swift
//  RxWeather
//
//  Created by Hussein Anwar on 11/01/2023.
//

import Foundation

extension URL {
    
    static func urlForWeatherAPI(city: String) -> URL? {
        return URL(string: "http://api.weatherstack.com/current?access_key=dcfe7a59c539019b5ce05ff71b022cd9&query=\(city)")
    }
    
}
