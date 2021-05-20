//
//  CSChildViewController.swift
//  IPAOccupancy
//
//  Created by Scheidegger, Jaden on 20.05.21.
//  Copyright © 2021 SAP. All rights reserved.
//

import UIKit

class CSChildViewController: UIViewController {

    //Variable for passed username Value from TabBar
    var username: String?
    //Instantiate settingsClubModel
    var settingsClubModel = SettingsClubModel()
    //Default value of UIPicker (starts in middle)
    var club = "4"

    
    @IBOutlet weak var currentClubLabel: UILabel!
    @IBOutlet weak var newClubLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var clubPicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func confirmPressed(_ sender: UIButton) {
    }
    
    
    //MARK: - View styling
    //method to change look of the view
    func configureView() {
        view.backgroundColor = UIColor.preferredFioriColor(forStyle: .primary9)
        view.layer.cornerRadius = 10
    }
    
    //MARK: - Button styling
    //Method to change look of confirm button
    func configureButton() {
        confirmButton.layer.cornerRadius = 5
        confirmButton.setTitle("Confirm", for: .normal)
    }
    
    //MARK: - Label styling
    //Method to change look of Labels
    func configureLabels() {
        currentClubLabel.font = UIFont.preferredFioriFont(forTextStyle: .headline)
        newClubLabel.font = UIFont.preferredFioriFont(forTextStyle: .subheadline)
    }
    //Method to configure current Club Label
    func configureCurrentClubLabel() {
        //TODO: OData Call
    }
}

//MARK: - PickerView Datasource & Delegate Methods
extension CSChildViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    //Method to set Datasource and Delegate for UIPicker (Also selects starting row)
    func configureUIPicker() {
        clubPicker.dataSource = self
        clubPicker.delegate = self
        clubPicker.selectRow(3, inComponent: 0, animated: true)
    }
    
    //Method to set number of colums each row has
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    //Method to set the number of components the UIPicker should have
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        settingsClubModel.clubNumbers.count
    }
    //Method to set the title for each row of the UIPicker
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "Club \(settingsClubModel.clubNumbers[row])"
    }
   
    //Method to set user selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        club = settingsClubModel.clubNumbers[row]
    }
    
    
    
}
