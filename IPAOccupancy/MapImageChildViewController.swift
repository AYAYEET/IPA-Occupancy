//
//  MapImageChildViewController.swift
//  IPAOccupancy
//
//  Created by Scheidegger, Jaden on 20.05.21.
//  Copyright © 2021 SAP. All rights reserved.
//

import UIKit

class MapImageChildViewController: UIViewController {

    @IBOutlet weak var occupancyLabel: UILabel!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var club1Label: UILabel!
    @IBOutlet weak var club2Label: UILabel!
    @IBOutlet weak var club3Label: UILabel!
    @IBOutlet weak var club4Label: UILabel!
    @IBOutlet weak var club5Label: UILabel!
    @IBOutlet weak var club6Label: UILabel!
    @IBOutlet weak var club7Label: UILabel!
    @IBOutlet weak var club8Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureView()
        configureLabel()
    }
    
    //What happens when reload button is pressed
    @IBAction func reloadPressed(_ sender: UIButton) {
    }
    
    
    //MARK: - Label styling
    //Method for changing look of labels
    fileprivate func configureLabel() {
        occupancyLabel.font = UIFont.preferredFioriFont(forTextStyle: .headline)
        
        hintLabel.font = UIFont.preferredFioriFont(forTextStyle: .subheadline)
        hintLabel.textColor = UIColor.preferredFioriColor(forStyle: .primary3)
        
        club1Label.font = UIFont.preferredFioriFont(forTextStyle: .subheadline)
        club2Label.font = UIFont.preferredFioriFont(forTextStyle: .subheadline)
        club3Label.font = UIFont.preferredFioriFont(forTextStyle: .subheadline)
        club4Label.font = UIFont.preferredFioriFont(forTextStyle: .subheadline)
        club5Label.font = UIFont.preferredFioriFont(forTextStyle: .subheadline)
        club6Label.font = UIFont.preferredFioriFont(forTextStyle: .subheadline)
        club7Label.font = UIFont.preferredFioriFont(forTextStyle: .subheadline)
        club8Label.font = UIFont.preferredFioriFont(forTextStyle: .subheadline)
    }
    
    //MARK: - View styling
    //Method for changing look of view
    fileprivate func configureView() {
        view.backgroundColor = UIColor.preferredFioriColor(forStyle: .primary9)
        view.layer.cornerRadius = 10
    }
    
}
