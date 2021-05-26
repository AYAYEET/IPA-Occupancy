//
//  BookingGeneralChildViewController.swift
//  IPAOccupancy
//
//  Created by Scheidegger, Jaden on 21.05.21.
//  Copyright © 2021 SAP. All rights reserved.
//

import UIKit
import SAPFiori

class BookingGeneralChildViewController: UIViewController {
    
    //Instantiate bookingModel
    let bookingModel = BookingModel()

    //Storyboard connections
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
    @IBOutlet weak var messageView: UIView!
    
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
    
    //What happens when reload Button is pressed
    @IBAction func reloadPressed(_ sender: UIButton) {
        configureLabelText()
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
        bookingModel.getCurrentClubData { (currentlyFreeArray, status) in
            if status == Constants.Booking.success {
                self.descTotalLabel.text = "A look at the current occupancy at\nThe Circle Office.\nCurrent free spaces: \(currentlyFreeArray.reduce(0, +))" //Adds all values in array together.
                self.club1Label.text = "Club 1: \(currentlyFreeArray[0])"
                self.club2Label.text = "Club 2: \(currentlyFreeArray[1])"
                self.club3Label.text = "Club 3: \(currentlyFreeArray[2])"
                self.club4Label.text = "Club 4: \(currentlyFreeArray[3])"
                self.club5Label.text = "Club 5: \(currentlyFreeArray[4])"
                self.club6Label.text = "Club 6: \(currentlyFreeArray[5])"
                self.club7Label.text = "Club 7: \(currentlyFreeArray[6])"
                self.club8Label.text = "Club 8: \(currentlyFreeArray[7])"
            } else {
                FUIToastMessage.show(message: "There was an issue fetching the Club Data. Please retry.",
                                             icon: UIImage(systemName: "exclamationmark.circle")!,
                                             inView: self.messageView,
                                             withDuration: 3.0,
                                             maxNumberOfLines: 0)
            }
        }
    }
}
