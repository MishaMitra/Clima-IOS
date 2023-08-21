//
//  WeatherManager.swift
//  Clima
//
//  Created by Михаил Кузнецов on 12.06.2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//
import CoreLocation
import Foundation
 // protocol for realize Delegate Design Pattern
protocol WeatherManagerDelegate {
    
    func didUpdateWeather (_ weatherManager : WeatherManager, weather : WeatherModel)
    func didFailWithError (error : Error)
}

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=1a9f492a249fd146dfb47721a380f8ab&units=metric"
    
    var delegate : WeatherManagerDelegate?
    
    func fetchWeather (cityName:String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest (with : urlString)
    }
    
    func fetchWeather(latitude : CLLocationDegrees, longitude : CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest (with : urlString)
    }
    
    func performRequest (with urlString:String) {
        // 1. create a URL
        if let url = URL(string: urlString) {
            
            
            // 2. create a URL Session (like browser)
            let sessionObject = URLSession(configuration: .default)
            
            // 3. give the session a task with closure and put it into an object
            
            let task = sessionObject.dataTask(with: url) { data, response, error in
                if error != nil {
                    // handle network error with delegate (Weather View Controller)
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                // handle first data parse it and send to the delegate method
                if let safeData = data {
                    //let dataString = String (data: safeData, encoding: .utf8)
                    if let weather = self.parseJSON(safeData) {
                        
                        self.delegate?.didUpdateWeather(self, weather: weather)
                        
                    }
                }
            }
            // 4. start the task
            task.resume()
            
        }
    }
    
    //parsing our data from json to swift
    func parseJSON (_ weatherData:Data) -> WeatherModel? {
        //create decoder object
        let decoder = JSONDecoder ()
        do{
            // decode our date using .decode method,using WeatherData struct and put it into decodeData object
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            //create an object Type WeatherModel to pass it like retunt of our parseJSON func throw the task session to the delegate method (48)
            let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp)
            return weather
            // print(weather.temperatureString)
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    
}




