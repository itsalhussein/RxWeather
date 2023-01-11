//
//  Weather.swift
//  RxWeather
//
//  Created by Hussein Anwar on 11/01/2023.
//

import Foundation

// MARK: - Weather
struct Weather : Codable {
    var request : Request?
    var location : Location?
    var current : Current?
}



// MARK: - Current
struct Current : Codable {
    var observation_time : String?
    var temperature : Int?
    var weather_code : Int?
    var weather_icons : [String]?
    var weather_descriptions : [String]?
    var wind_speed : Int?
    var wind_degree : Int?
    var wind_dir : String?
    var pressure : Int?
    var precip : Int?
    var humidity : Int?
    var cloudcover : Int?
    var feelslike : Int?
    var uv_index : Int?
    var visibility : Int?
    var is_day : String?
}


// MARK: - Location
struct Location : Codable {
    var name : String?
    var country : String?
    var region : String?
    var lat : String?
    var lon : String?
    var timezone_id : String?
    var localtime : String?
    var localtime_epoch : Int?
    var utc_offset : String?
}


// MARK: - Request
struct Request : Codable {
    var type : String?
    var query : String?
    var language : String?
    var unit : String?
}


extension Weather {
    static var empty : Weather {
        var requet = Request()
        var location = Location()
        var current = Current()
        current.temperature = 0
        current.humidity = 0
        return Weather(request: requet, location: location, current: current)
    }
}
