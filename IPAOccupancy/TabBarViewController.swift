//
//  TabBarViewController.swift
//  IPAOccupancy
//
//  Created by Scheidegger, Jaden on 19.05.21.
//  Copyright © 2021 SAP. All rights reserved.
//  This VC gets the password from loginVC and also ensures it gets saved to UserDefaults for future use
//  Also passes the username to SettingsVC, MapVC and BookingVC

import UIKit

class TabBarViewController: UITabBarController {

    //Variable passed from LoginVC
    var username: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        checkUsername()
    }
    
    //MARK: - iNumber (username) reference
    //Method to save the iNumber for future use
    func checkUsername() {
        if username != nil {
            //When the username is passed (during log in) set it as userdefaults for username
            UserDefaults.standard.set(username, forKey: "username")
        } else {
            //During later launches of the App log in isn't needed, so username is taken from userdefaults
            username = UserDefaults.standard.string(forKey: "username")
        }
       
    }
}
