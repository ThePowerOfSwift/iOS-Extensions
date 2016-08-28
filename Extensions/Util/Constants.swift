//
//  Constants.swift
//  Extensions
//
//  Created by Mihail Șalari on 8/26/16.
//  Copyright © 2016 Mihail Șalari. All rights reserved.
//
import UIKit

struct Constants {
    
    static let GradeSign = " \u{00B0}"
    static let Defaults = UserDefaults(suiteName: "group.com.mihailsalari.Extensions")
    static let DefaultsCityKey = "city"
    static var SelectedCity = "Cisinau, Moldova"

    struct CitiesViewController {
        static let CityCellIdentifier = "CityCell"
        
    }
    
    struct MainViewController {
        static let SegueShowCities = "ShowCity"
    }
}
