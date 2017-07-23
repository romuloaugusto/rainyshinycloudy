//
//  Constants.swift
//  rainyshinycloudy
//
//  Created by Romulo Augusto on 08/07/17.
//  Copyright © 2017 Romulo Augusto. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "aaae943afbb76adb1c06f156395d173d"

typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&units=metric&appid=aaae943afbb76adb1c06f156395d173d"
let FORECAST_WEATHER_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&cnt=10&mode=json&units=metric&appid=aaae943afbb76adb1c06f156395d173d"

