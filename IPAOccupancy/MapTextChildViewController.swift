//
//  MapTextChildViewController.swift
//  IPAOccupancy
//
//  Created by Scheidegger, Jaden on 20.05.21.
//  Copyright © 2021 SAP. All rights reserved.
//

import UIKit

class MapTextChildViewController: UIViewController {

    //Variable for passed username Value from TabBar
    var username: String?
    //Instantiate mapTextModel
    let mapTextModel = MapTextModel()
    
    @IBOutlet weak var bookedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - View styling
    //Method for changing look of view
    fileprivate func configureView() {
        view.backgroundColor = UIColor.preferredFioriColor(forStyle: .primary9)
        view.layer.cornerRadius = 10
    }
    


}
