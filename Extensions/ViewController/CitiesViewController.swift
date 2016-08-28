//
//  CitiesViewController.swift
//  Extensions
//
//  Created by Mihail Șalari on 8/26/16.
//  Copyright © 2016 Mihail Șalari. All rights reserved.
//

import UIKit

class CitiesViewController: UITableViewController {
    
    // MARK: - Properties
    
    let city = ["Cisinau, Moldova", "Bucharest, Romania", "Seattle, United States"]
    var selectedCity = "Cisinau, Moldova"
    

    // MARK: - Lyfe Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let customFooterView = UIView(frame: CGRect.zero)
        self.tableView.tableFooterView = customFooterView
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return city.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CitiesViewController.CityCellIdentifier, for: indexPath)
        cell.textLabel?.text = city[indexPath.row]
        cell.accessoryType = city[indexPath.row] == selectedCity ? .checkmark : .none
        cell.textLabel?.textColor = UIColor.white
        
        return cell
    }
 
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark

        if let cityName = cell?.textLabel?.text {
            selectedCity = cityName
            Constants.Defaults?.setValue(selectedCity, forKeyPath: Constants.DefaultsCityKey)
        }
        self.tableView?.reloadData()
    }
}
