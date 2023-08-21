//
//  WeatherData.swift
//  Clima
//
//  Created by Михаил Кузнецов on 15.06.2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
// this file helps us to Decode with parseJSON func
struct WeatherData : Decodable {
    
    let name : String
    let main : Main
    let weather : [Weather]
    
    
}

struct Main : Decodable {
    let temp: Double
}

struct Weather : Decodable {
    let id : Int
    let main : String
    let description : String
}

