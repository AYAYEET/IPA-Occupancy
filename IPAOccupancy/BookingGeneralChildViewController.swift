//
//  BookingGeneralChildViewController.swift
//  IPAOccupancy
//
//  Created by Scheidegger, Jaden on 21.05.21.
//  Copyright © 2021 SAP. All rights reserved.
//

import UIKit

class BookingGeneralChildViewController: UIViewController {
    
    //Instantiate bookingModel
    let bookingModel = BookingModel()

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descTotalLabel: UILabel!
    @IBOutlet weak var club1Label: UILabel!
    @IBOutlet weak var club2Label: UILabel!
    @IBOutlet weak var club3Label: UILabel!
    @IBOutlet weak var club4Label: UILabel!
    @IBOutlet weak var club5Label: UILabel!
    @IBOutlet weak var club6Label: UILabel!
    @IBOutlet weak var club7Label: UILabel!
    @IBOutlet weak var club8Label: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        configureLabelText()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureView()
        configureLabels()
    }
    
    @IBAction func reloadPressed(_ sender: UIButton) {
    }
    
    //MARK: - View styling
    //Method for changing look of view
    fileprivate func configureView() {
        view.backgroundColor = UIColor.preferredFioriColor(forStyle: .primary9)
        view.layer.cornerRadius = 10
    }
    
    //MARK: - Label styling
    //Method for changing look of labels
    fileprivate func configureLabels() {
        titleLabel.font = UIFont.preferredFioriFont(forTextStyle: .headline)
        descTotalLabel.font = UIFont.preferredFioriFont(forTextStyle: .subheadline)
        descTotalLabel.textColor = UIColor.preferredFioriColor(forStyle: .primary3)
        club1Label.font = UIFont.preferredFioriFont(forTextStyle: .body)
        club2Label.font = UIFont.preferredFioriFont(forTextStyle: .body)
        club3Label.font = UIFont.preferredFioriFont(forTextStyle: .body)
        club4Label.font = UIFont.preferredFioriFont(forTextStyle: .body)
        club5Label.font = UIFont.preferredFioriFont(forTextStyle: .body)
        club6Label.font = UIFont.preferredFioriFont(forTextStyle: .body)
        club7Label.font = UIFont.preferredFioriFont(forTextStyle: .body)
        club8Label.font = UIFont.preferredFioriFont(forTextStyle: .body)
    }
    
    //MARK: - Configure Label Data
    //Method for changing label text to currentlyFree
    func configureLabelText() {

        
        
    }

}
