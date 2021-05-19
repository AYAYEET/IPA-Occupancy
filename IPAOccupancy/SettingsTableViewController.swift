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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTable()

     
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
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

}
