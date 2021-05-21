//
//  BookingReserveChildViewController.swift
//  IPAOccupancy
//
//  Created by Scheidegger, Jaden on 21.05.21.
//  Copyright © 2021 SAP. All rights reserved.
//

import UIKit

class BookingReserveChildViewController: UIViewController {

    //Variable for passed username Value from TabBar
    var username: String?
    //Instantiate bookingReserveModel
    let bookingReserveModel = BookingReserveModel()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descClubLabel: UILabel!
    @IBOutlet weak var descRandomLabel: UILabel!
    @IBOutlet weak var reservepreferredButton: UIButton!
    @IBOutlet weak var reserverandomButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureView()
        configureLabels()
        configureButtons()
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
        descClubLabel.font = UIFont.preferredFioriFont(forTextStyle: .subheadline)
        descClubLabel.textColor = UIColor.preferredFioriColor(forStyle: .primary3)
        descRandomLabel.font = UIFont.preferredFioriFont(forTextStyle: .subheadline)
        descRandomLabel.textColor = UIColor.preferredFioriColor(forStyle: .primary3)
    }
    
    //MARK: - Button styling
    fileprivate func configureButtons() {
        reservepreferredButton.layer.cornerRadius = 5
        reserverandomButton.layer.cornerRadius = 5
    }
    
    


}
