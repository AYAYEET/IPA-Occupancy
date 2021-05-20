//
//  ASChildViewController.swift
//  IPAOccupancy
//
//  Created by Scheidegger, Jaden on 20.05.21.
//  Copyright © 2021 SAP. All rights reserved.
//

import UIKit

class ASChildViewController: UIViewController {

    //Variable for passed username Value from TabBar
    var username: String?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var reNewPasswordTextField: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var messageView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureView()
        configureButton()
        configureTextFields()
        configureLabel()
    }
    
    //MARK: - View styling
    //Method to change look of the view
    func configureView() {
        view.backgroundColor = UIColor.preferredFioriColor(forStyle: .primary9)
        view.layer.cornerRadius = 10
    }
    
    //MARK: - Label styling
    //Method to change look of label
    func configureLabel() {
        titleLabel.font = UIFont.preferredFioriFont(forTextStyle: .headline)
    }
    
    //MARK: - Button styling
    //Method to change look of confirm button and set it to be disabled
    func configureButton() {
        confirmButton.layer.cornerRadius = 5
        confirmButton.setTitle("Confirm", for: .normal)
        confirmButton.isEnabled = false
    }
    
    //MARK: - Textfield Styling
    //Method to change look of Textfields
    fileprivate func configureTextFields() {
        passwordTextField.layer.borderWidth = 1.0
        newPasswordTextField.layer.borderWidth = 1.0
        reNewPasswordTextField.layer.borderWidth = 1.0
        
        passwordTextField.layer.cornerRadius = 5
        newPasswordTextField.layer.cornerRadius = 5
        reNewPasswordTextField.layer.cornerRadius = 5
        
        passwordTextField.layer.borderColor = Constants.General.gray
        newPasswordTextField.layer.borderColor = Constants.General.gray
        reNewPasswordTextField.layer.borderColor = Constants.General.gray
    }


}
