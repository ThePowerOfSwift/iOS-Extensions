//
//  TodayViewController.swift
//  Weather Widget
//
//  Created by Mihail Șalari on 8/26/16.
//  Copyright © 2016 Mihail Șalari. All rights reserved.
//

import UIKit
import NotificationCenter
import WeatherInfoKit

class TodayViewController: UIViewController, NCWidgetProviding {
    
    // MARK: - Properties
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var location = "Chisinau, Moldova"
    let defaultsValue = "city"
    
    
    // MARK: - Lyfe Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let loc = Constants.Defaults?.value(forKey: defaultsValue) as! String
        location = loc
        
        cityLabel.text = location
        
        // Invoke weather Service
        WeatherService.sharedWeatherService().getCurrentWeather(location: location) { [unowned self] (data, error) -> (Void) in
            DispatchQueue.main.async {
                if let weatherData = data {
                    self.descriptionLabel.text = weatherData.descriptionWeather.capitalized
                    self.temperatureLabel.text = "\(weatherData.temperature)" + Constants.GradeSign
                }
            }
        }
    }
    
    
    // MARK: - NCUpdateResult
    
    func widgetPerformUpdate(completionHandler: ((NCUpdateResult) -> Void)) {

        // Get the location from defaults
        
        let newLocation = Constants.Defaults?.value(forKey: defaultsValue) as! String
        location = newLocation
        cityLabel.text = location
        
        WeatherService.sharedWeatherService().getCurrentWeather(location: location) { [unowned self] (data, error) -> (Void) in
            
            if error == nil {
                DispatchQueue.main.async {
                    if let weatherData = data {
                        self.descriptionLabel.text = weatherData.descriptionWeather.capitalized
                        self.temperatureLabel.text = "\(weatherData.temperature)" + Constants.GradeSign
                    }
                }
                completionHandler(.newData)
            } else {
                completionHandler(.noData)
            }
        }
    }
}
