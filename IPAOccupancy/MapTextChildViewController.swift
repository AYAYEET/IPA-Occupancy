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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        configureLabelText()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureView()
    }
    
    //MARK: - View styling
    //Method for changing look of view
    fileprivate func configureView() {
        view.backgroundColor = UIColor.preferredFioriColor(forStyle: .primary9)
        view.layer.cornerRadius = 10
    }
    
    //MARK: - Configure Label Data
    //Method for changing label text based on booked club
    func configureLabelText() {
        mapTextModel.checkForBooked(username: username) { (club) in
            switch club {
            case "1":
                self.bookedLabel.text = "You have a Desk booked in Club \(club)"
            case "2":
                self.bookedLabel.text = "You have a Desk booked in Club \(club)"
            case "3":
                self.bookedLabel.text = "You have a Desk booked in Club \(club)"
            case "4":
                self.bookedLabel.text = "You have a Desk booked in Club \(club)"
            case "5":
                self.bookedLabel.text = "You have a Desk booked in Club \(club)"
            case "6":
                self.bookedLabel.text = "You have a Desk booked in Club \(club)"
            case "7":
                self.bookedLabel.text = "You have a Desk booked in Club \(club)"
            case "8":
                self.bookedLabel.text = "You have a Desk booked in Club \(club)"
            case Constants.Map.notReserved:
                self.bookedLabel.text = "You haven't reserved yet."
            default:
                do{}
            }
        }
    }


}
