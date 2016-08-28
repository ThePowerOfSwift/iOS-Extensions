//
//  MainViewController.swift
//  Extensions
//
//  Created by Mihail Șalari on 8/26/16.
//  Copyright © 2016 Mihail Șalari. All rights reserved.
//

import UIKit
import WeatherInfoKit

class MainViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var city = "Chisinau"
    var country = "Moldova"
    
    
    // MARK: - Lyfe Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        descriptionLabel.text = ""
        temperatureLabel.text = ""
        self.displayCurrentWeather()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Get current weather
    
    func displayCurrentWeather() {
        cityLabel.text = city
        countryLabel.text = country
        
        // Invoke weather Service
        WeatherService.sharedWeatherService().getCurrentWeather(location: city + "," + country) { [unowned self] (data, error) -> (Void) in
            DispatchQueue.main.async {
                if let weatherData = data {
                    self.descriptionLabel.text = weatherData.descriptionWeather.capitalized
                    self.temperatureLabel.text = "\(weatherData.temperature)" + Constants.GradeSign
                }
            }
        }
    }

    
    // MARK: @IBAction's
    
    @IBAction func updateWeatherInfo(segue: UIStoryboardSegue) {
        let sourceViewController = segue.source as! CitiesViewController
        
        var selectedCity = sourceViewController.selectedCity.components(separatedBy: ",")
        city = selectedCity[0]
        country = selectedCity[1].trimmingCharacters(in: NSCharacterSet.whitespaces)
        
        self.displayCurrentWeather()
    }
    
    @IBAction func unwindToMain(segue: UIStoryboardSegue) { }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.MainViewController.SegueShowCities {
            let citiesViewController = segue.destination.contentViewController as! CitiesViewController
            citiesViewController.selectedCity = "\(city), \(country)"
        }
    }
}
