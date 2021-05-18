//
//  RegisterViewController.swift
//  IPAOccupancy
//
//  Created by Scheidegger, Jaden on 18.05.21.
//  Copyright © 2021 SAP. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordReTextField: UITextField!
    @IBOutlet weak var clubPicker: UIPickerView!
    @IBOutlet weak var selectClubLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureTextFields()
        configureButton()
        delegateTextFields()
        configureUsernameLabel()
    }
    

    @IBAction func registerPressed(_ sender: Any) {
    }
    
    //MARK: - UITextfield Methods
    //Method to change look of TextFields
    fileprivate func configureTextFields() {
        usernameTextField.layer.borderWidth = 1.0
        passwordTextField.layer.borderWidth = 1.0
        passwordReTextField.layer.borderWidth = 1.0
        
        usernameTextField.layer.cornerRadius = 5
        passwordTextField.layer.cornerRadius = 5
        passwordReTextField.layer.cornerRadius = 5
        
        usernameTextField.layer.borderColor = Constants.General.gray
        passwordTextField.layer.borderColor = Constants.General.gray
        passwordReTextField.layer.borderColor = Constants.General.gray
        
        //Textfields for Password and Re Password are disabled until valid Username is entered
        passwordTextField.isUserInteractionEnabled = false
        passwordReTextField.isUserInteractionEnabled = false
        passwordTextField.placeholder = Constants.Register.validUsername
    }
    
    //MARK: - Button Styling
    //Method to change look of button
    fileprivate func configureButton() {
        registerButton.layer.cornerRadius = 5
        registerButton.isEnabled = false
    }
    
    //MARK: - Text for username and password Labels (Password hints)
    //Method to set text in username Label
    fileprivate func configureUsernameLabel() {
        usernameLabel.text = Constants.Register.iNumberExample
    }
    //Method to set text in password Label
    fileprivate func configurePasswordLabel() {
        passwordLabel.text = Constants.Register.passwordExample
    }
}

//MARK: - Textfield Delegate Methods
extension RegisterViewController: UITextFieldDelegate {
    //A Delegate Method of UITextfields, happens when return Button is pressed.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.nextTextField(textField)
        return true
    }
    
    //Switches selected textfield to the next textfield
    private func nextTextField(_ textField: UITextField) {
        switch textField {
        case self.usernameTextField:
            self.passwordTextField.becomeFirstResponder()
        case self.passwordTextField:
            self.passwordReTextField.becomeFirstResponder()
        default:
            self.passwordReTextField.resignFirstResponder()
        }
    }
    
    //Delegate Textfields to respond to actions and data in textfields
    fileprivate func delegateTextFields() {
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        passwordReTextField.delegate = self
    }
}
