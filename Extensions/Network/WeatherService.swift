//
//  WeatherService.swift
//  Extensions
//
//  Created by Mihail Șalari on 8/26/16.
//  Copyright © 2016 Mihail Șalari. All rights reserved.
//

import UIKit

// Shared
let _sharedWeatherService: WeatherService = {
    WeatherService()
}()


public class WeatherService: NSObject {
    
    // MARK: - Properties
    
    public typealias WeatherDataCompletionBlock = ((_ date: WeatherData?, _ error: NSError?) -> (Void))
    let openWeatherBaseAPI = "http://api.openweathermap.org/data/2.5/weather?units=metric&q="
    let token = "&appid=1e89a71ea0f825746ead5edd964a2f0e"
    let urlSession = URLSession.shared
    
    
    
    // MARK: - Shared Instance
    
    public class func sharedWeatherService() -> WeatherService {
        return _sharedWeatherService
    }
    
    
    // MARK: - Get current Weather
    
    public func getCurrentWeather(location: String, completion: WeatherDataCompletionBlock) {
        
        let openWeatherAPI = openWeatherBaseAPI + location.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlHostAllowed)! + token
        
        let request = URLRequest(url: URL(string: openWeatherAPI)!)
        
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription)
            }
            
            // Parse JSON Data
            do {
                let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                
                let weatherData = WeatherData(weatherDictionary: jsonResult)
                completion(weatherData, nil)
                
            } catch {
                if let error = error as NSError? {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}
