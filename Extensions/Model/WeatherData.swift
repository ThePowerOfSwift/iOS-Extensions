//
//  WeatherData.swift
//  Extensions
//
//  Created by Mihail Șalari on 8/26/16.
//  Copyright © 2016 Mihail Șalari. All rights reserved.
//

import UIKit

public class WeatherData {

    // MARK: - Properties
    
    public let temperature: Int
    public var descriptionWeather: String = ""
    
    
    // MARK: - Initlializers
    
    public init(weatherDictionary: NSDictionary) {
        
        // Parce JSON Data
        let jsonWeather = weatherDictionary["weather"] as! [AnyObject]
        
        for jsonCurrentWeather in jsonWeather {
            descriptionWeather = jsonCurrentWeather["description"] as! String
        }
        
        let jsonMain = weatherDictionary["main"] as! [String: AnyObject]
        temperature = jsonMain["temp"] as! Int
    }
}
