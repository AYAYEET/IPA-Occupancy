//
//  SettingsTableViewController.swift
//  IPAOccupancy
//
//  Created by Scheidegger, Jaden on 19.05.21.
//  Copyright © 2021 SAP. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    //Variable for passed username Value from TabBar
    var username: String?
    
    //Instantiate settingsRowModel
    var settingsRowModel = [SettingsRowModel]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTable()
        configureModel()

     
    }
    //What happens when Log Out Button is pressed
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: Constants.Settings.logoutSegue, sender: self)
    }
    
    //MARK: - Design & Basic elements Table VC
    //Method for general configuration of Table
    func configureTable() {
        tableView.dataSource = self
        tableView.delegate = self
        
        //Register a UITableViewCell as the class to use for creating new cells
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
    }
    
    // MARK: - Table view data source
    //Method that informs Table of number of cells it needs.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settingsRowModel.count
    }
    
    //Method that informs Table of how to create each cell.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = settingsRowModel[indexPath.row]
        
        //Dequeue custom cell, if something goes wrong dequeue a standard cell
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SettingsTableViewCell.identifier,
                for: indexPath
        ) as? SettingsTableViewCell else {
            return UITableViewCell()
        }
        //Add Model Data to cell
        cell.configureCell(model: model)
        return cell
    }
    
    //Method that gets triggered when a cell is pressed.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = settingsRowModel[indexPath.row]
        model.action()
    }
    
    //MARK: - settingsRowModel Data
    //Method to add Values to the model
    func configureModel() {
        self.settingsRowModel = [
            SettingsRowModel(iconBackgroundColor: .systemPink,
                             icon: UIImage(systemName: "mappin.and.ellipse"),
                             title: "Club Settings",
                             action: {
                                self.performSegue(withIdentifier: Constants.Settings.clubSettingsSegue, sender: self)
            }),
            SettingsRowModel(iconBackgroundColor: .blue,
                             icon: UIImage(systemName: "person.crop.circle"),
                             title: "Account Settings",
                             action: {
                                self.performSegue(withIdentifier: Constants.Settings.accountSettingsSegue, sender: self)
            })
        ]
    }
    
     //MARK: - Navigation Preparation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Constants.Settings.clubSettingsSegue:
            let destinationVC = segue.destination as! CSViewController
            destinationVC.username = username
            
        case Constants.Settings.logoutSegue:
            //setting userdefaults for decision between main and login --> Here false
            UserDefaults.standard.set(false, forKey: "status")
            
        case Constants.Settings.accountSettingsSegue:
            let destinationVC = segue.destination as! ASViewController
            destinationVC.username = username
            
        default:
            do{}
        }
    }
}
