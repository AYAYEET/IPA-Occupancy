//
//  MapImageChildViewController.swift
//  IPAOccupancy
//
//  Created by Scheidegger, Jaden on 20.05.21.
//  Copyright © 2021 SAP. All rights reserved.
//

import UIKit
import SAPFiori

class MapImageChildViewController: UIViewController {

    //Instantiate mapModel
    let mapModel = MapModel()
    
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
    @IBOutlet weak var messageView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setClubData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureView()
        configureLabel()
    }
    
    //What happens when reload button is pressed
    @IBAction func reloadPressed(_ sender: UIButton) {
    }
    
    //MARK: - Label Data
    //Method to set value and color in labels
    fileprivate func setClubData() {
        mapModel.getCurrentClubData { (currentlyFreeArray, status) in
            //Ensure OData Request was successful
            if status == Constants.Map.success {
                self.club1Label.text = "Club 1 \(self.mapModel.calculatePercent(value: currentlyFreeArray[0], maxValue: self.mapModel.club1Max))%"
                self.club2Label.text = "Club 2 \(self.mapModel.calculatePercent(value: currentlyFreeArray[1], maxValue: self.mapModel.club2Max))%"
                self.club3Label.text = "Club 3 \(self.mapModel.calculatePercent(value: currentlyFreeArray[2], maxValue: self.mapModel.club3Max))%"
                self.club4Label.text = "Club 4 \(self.mapModel.calculatePercent(value: currentlyFreeArray[3], maxValue: self.mapModel.club4Max))%"
                self.club5Label.text = "Club 5 \(self.mapModel.calculatePercent(value: currentlyFreeArray[4], maxValue: self.mapModel.club5Max))%"
                self.club6Label.text = "Club 6 \(self.mapModel.calculatePercent(value: currentlyFreeArray[5], maxValue: self.mapModel.club6Max))%"
                self.club7Label.text = "Club 7 \(self.mapModel.calculatePercent(value: currentlyFreeArray[6], maxValue: self.mapModel.club7Max))%"
                self.club8Label.text = "Club 8 \(self.mapModel.calculatePercent(value: currentlyFreeArray[7], maxValue: self.mapModel.club8Max))%"
                self.hintLabel.text = "Current occupancy data:\nTotal occupancy: \(self.mapModel.calculatePercent(value: currentlyFreeArray.reduce(0, +), maxValue: self.mapModel.occupancyMax))%"
            } else {
                FUIToastMessage.show(message: "There was an issue fetching the Club Data. Please retry.",
                                             icon: UIImage(systemName: "exclamationmark.circle")!,
                                             inView: self.messageView,
                                             withDuration: 3.0,
                                             maxNumberOfLines: 0)
            }
        }
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
