//
//  WeatherCell.swift
//  rainyshinycloudy
//
//  Created by Romulo Augusto on 09/07/17.
//  Copyright © 2017 Romulo Augusto. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    
    func configCell(forecast: Forecast) {
        self.lowTemp.text = forecast.lowTemp
        self.highTemp.text = forecast.highTemp
        self.dayLabel.text = forecast.date
        self.weatherType.text = forecast.weatherType
        self.weatherIcon.image = UIImage(named: forecast.weatherType)
    }


}
