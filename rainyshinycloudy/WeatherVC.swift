//
//  WeatherVC.swift
//  rainyshinycloudy
//
//  Created by Romulo Augusto on 07/07/17.
//  Copyright © 2017 Romulo Augusto. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        currentWeather = CurrentWeather()
//        currentWeather.downloadWeatherDetails {
//            print("in downloadWeatherDetails")
//            self.downloadForecastData {
//                print("in donwloadForecastData")
//                self.updateMainUI()
//            }
//        }
        
//        currentWeather.downloadWeatherDetails2 {
//            self.updateMainUI()
//        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
        
    }
    
    func locationAuthStatus() {
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            print(Location.sharedInstance.latitude, Location.sharedInstance.longitude)
            currentWeather.downloadWeatherDetails {
                print("in downloadWeatherDetails")
                self.downloadForecastData {
                    print("in donwloadForecastData")
                    self.updateMainUI()
                }
            }


        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func downloadForecastData(complete: @escaping DownloadComplete) {
        let forecastURL = URL(string: FORECAST_WEATHER_URL)!
        print(forecastURL)
        Alamofire.request(FORECAST_WEATHER_URL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                        print(obj)
                    }
                    self.forecasts.remove(at: 0)
                    self.tableView.reloadData()
                }
                
            }
            complete()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            cell.configCell(forecast: forecasts[indexPath.row])
            return cell
        } else {
            return WeatherCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }


    func updateMainUI() {
        print("Performing updateMainUI...")
        print("###\(currentWeather.date)")
        print("###\(currentWeather.cityName)")
        print("###\(currentWeather.currentTemp)")
        print("###\(currentWeather.weatherType)")
        
        dateLabel.text = currentWeather.date
        locationLabel.text = currentWeather.cityName
        currentTempLabel.text = "\(currentWeather.currentTemp)"
        currentWeatherLabel.text = currentWeather.weatherType
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
        
        print("finishing updateMainUI...")

    }

}

