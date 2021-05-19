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
        passUsername()
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
    
    //MARK: - Passing Username to other VC
    //Method for passing username to SettingsVC, MapVC and BookingVC
    func passUsername() {
        //Creates an array of the viewControllers in TabBarVC
        guard let viewControllers = viewControllers else { return }
        
        //Searches for the NaviationVC that matches type SettingsNav... in the viewControllers array
        for viewController in viewControllers {
            if let SettingsNavigationViewController = viewController as? SettingsNavigationViewController {
                
                //Ensures the correct VC is chosen from NavigationVC
                if let SettingsViewController = SettingsNavigationViewController.viewControllers.first as? SettingsTableViewController {
                    //Pass the username
                    SettingsViewController.username = username
                }
            }
        }
        
        for viewController in viewControllers {
            if let MapNavigationController = viewController as? MapNavigationViewController {
                
                if let MapViewController = MapNavigationController.viewControllers.first as? MapViewController {
                    MapViewController.username = username
                }
            }
        }
        
        for viewController in viewControllers {
            if let BookingNavigationController = viewController as? BookingNavigationViewController {
                
                if let BookingViewController = BookingNavigationController.viewControllers.first as? BookingViewController {
                    BookingViewController.username = username
                }
            }
        }
    }
}
