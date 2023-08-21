//
//  WeatherModel.swift
//  Clima
//
//  Created by Михаил Кузнецов on 16.06.2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
// Model with date to be shown on screen
// Objec of this Type will be create to sent ora data thow delegate to the screen

struct WeatherModel {
    let conditionID : Int
    let cityName : String
    let temperature : Double
    
    var temperatureString : String {
        return String(format:"%.1f", temperature)
    }
    
    // computed propriete
    var conditionName : String {
        switch conditionID {
        case  200...232 :
            return "cloud.bolt"
            
        case 300...321 :
            return "cloud.drizzle"
        case 500...531 :
            return "cloud.rain"
        case 600...622 :
            return "cloud.snow"
        case 701...781 :
            return "smoke"
        case 800 :
            return "sun.max"
        case 801...804 :
            return "cloud.sun"
        default:
            return "sun.max"
        }
    }
}
