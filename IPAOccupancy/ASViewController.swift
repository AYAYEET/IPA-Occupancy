//
//  ASViewController.swift
//  IPAOccupancy
//
//  Created by Scheidegger, Jaden on 20.05.21.
//  Copyright © 2021 SAP. All rights reserved.
//

import UIKit

class ASViewController: UIViewController {
    
    //Variable for passed username Value from TabBar
    var username: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Constants.Settings.aSChildSegue:
            let destinationVC = segue.destination as! ASChildViewController
            destinationVC.username = username
        default:
            do{}
        }
    }
    
}
