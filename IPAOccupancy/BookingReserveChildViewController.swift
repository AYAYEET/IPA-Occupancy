//
//  BookingReserveChildViewController.swift
//  IPAOccupancy
//
//  Created by Scheidegger, Jaden on 21.05.21.
//  Copyright © 2021 SAP. All rights reserved.
//

import UIKit
import SAPFiori

class BookingReserveChildViewController: UIViewController {
    
    //Variable for passed username Value from TabBar
    var username: String?
    //Instantiate bookingReserveModel
    let bookingReserveModel = BookingReserveModel()
    //Variables for Buttons to know what actions to perform when pressed
    var reserved = false
    var preferred = "1"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descClubLabel: UILabel!
    @IBOutlet weak var descRandomLabel: UILabel!
    @IBOutlet weak var reservepreferredButton: UIButton!
    @IBOutlet weak var reserverandomButton: UIButton!
    @IBOutlet weak var messageView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        configureDataInElements()
    }
    
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
    
    //MARK: - Data Config for Buttons and Labels
    //Method for configuring status of buttons and label text based on if user has booked or not
    func configureDataInElements() {
        bookingReserveModel.getUserClubReservation(username: username) { (preferredClub, reservedClub, hasReserved) in
            if preferredClub == Constants.Booking.connectionError {
                FUIToastMessage.show(message: "There was an issue fetching the Reservation Data. Please retry.",
                                     icon: UIImage(systemName: "exclamationmark.circle")!,
                                     inView: self.messageView,
                                     withDuration: 3.0,
                                     maxNumberOfLines: 0)
                self.reservepreferredButton.isEnabled = false
                self.reserverandomButton.isEnabled = false
            } else {
                self.bookingReserveModel.getFreeInPreferredClub(prefferedClub: preferredClub) { (freeSpaces, status) in
                    if status == Constants.Booking.connectionError {
                        FUIToastMessage.show(message: "There was an issue fetching the Reservation Data. Please retry.",
                                             icon: UIImage(systemName: "exclamationmark.circle")!,
                                             inView: self.messageView,
                                             withDuration: 3.0,
                                             maxNumberOfLines: 0)
                        self.reservepreferredButton.isEnabled = false
                        self.reserverandomButton.isEnabled = false
                    } else {
                        if hasReserved {
                            //what happens in the label when the user has already reserved
                            self.reservepreferredButton.isEnabled = true
                            self.reservepreferredButton.setTitle("Cancel your Reservation", for: .normal)
                            self.descClubLabel.text = "You currently have a desk reserved\nin Club \(reservedClub).\nYou can cancel your reservation below."
                            
                            self.reserverandomButton.isEnabled = false
                            self.reserverandomButton.setTitle("Cancel your Reservation above", for: .normal)
                            self.descRandomLabel.text = "Cancel your reservation in Club \(reservedClub)\nbefore you can reserve again."
                            
                        } else {
                            //what happens in the label when you haven't reserved
                            self.reservepreferredButton.isEnabled = true
                            self.reservepreferredButton.setTitle("Reserve in preferred Club", for: .normal)
                            self.descClubLabel.text = "There are currently \(freeSpaces ?? 1) desks\navailable in your preferred Club.\nYour preferred club is: Club \(preferredClub)"
                            
                            self.reserverandomButton.isEnabled = true
                            self.reserverandomButton.setTitle("Reserve in any Club", for: .normal)
                            self.descClubLabel.text = "Feel like sitting somewhere else today?"
                            
                            
                        }
                    }
                }
            }
        }
    }
    
}
