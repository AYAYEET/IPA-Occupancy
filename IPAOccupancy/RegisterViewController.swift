//
//  RegisterViewController.swift
//  IPAOccupancy
//
//  Created by Scheidegger, Jaden on 18.05.21.
//  Copyright © 2021 SAP. All rights reserved.
//

import UIKit
import SAPFiori
import SAPCommon

class RegisterViewController: UIViewController {
    //Instantiate registerModel
    let registerModel = RegisterModel()
    
    //Variable for UIPicker default value
    var club = "1"

    //Constants from the class RegexExtensions
    let iNumberValidityType: String.ValidityType = .iNumber
    let pwdValidityType: String.ValidityType = .password
    
    //Storyboard connections
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordReTextField: UITextField!
    @IBOutlet weak var clubPicker: UIPickerView!
    @IBOutlet weak var selectClubLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var messageView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureTextFields()
        configureButton()
        configureUsernameLabel()
        delegateTextFields()
        targetTextfields()
        configureUIPicker()
    }
    
    //What happens when Register Button is pressed
    @IBAction func registerPressed(_ sender: Any) {
        registerModel.registerUser(usernameTextFieldData: usernameTextField.text, passwordTextFieldData: passwordTextField.text, clubPickerValue: club) { (registerStatus) in
            //How to handle each return
            switch registerStatus {
            case Constants.Register.connectionError:
                FUIToastMessage.show(message: "Connection Error, try again",
                                             icon: UIImage(systemName: "exclamationmark.circle")!,
                                             inView: self.messageView,
                                             withDuration: 2.0,
                                             maxNumberOfLines: 1)
                
            case Constants.Register.createSuccess:
                //Dismiss the Register View
                self.dismiss(animated: true, completion: nil)
                
            case Constants.Register.createExists:
                FUIToastMessage.show(message: "This User already exists, retry login.",
                                             icon: UIImage(systemName: "exclamationmark.circle")!,
                                             inView: self.messageView,
                                             withDuration: 3.0,
                                             maxNumberOfLines: 2)
            default:
                do{}
            }
        }
    }
    
    //MARK: - UITextfield Methods
    //Method to change look of TextFields
    func configureTextFields() {
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
    func configureButton() {
        registerButton.layer.cornerRadius = 5
        registerButton.isEnabled = false
    }
    
    //MARK: - Text for username and password Labels (Password hints)
    //Method to set text in username Label
    func configureUsernameLabel() {
        usernameLabel.text = Constants.Register.iNumberExample
    }
    //Method to set text in password Label
    func configurePasswordLabel() {
        passwordLabel.text = Constants.Register.passwordExample
    }
    
    //MARK: - Methods for handling TextField changes and validating input
    
    //Add target to textfield for during editing for input validation
    //functionality heavily based on https://www.youtube.com/watch?v=mqaHpG1vPs8&list=PL_csAAO9PQ8buBXpnohnRyEbnYnXh81JE&index=1&t=676s
    func targetTextfields() {
        usernameTextField.addTarget(self, action: #selector(handleTextChangeUsername), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(handleTextChangePassword), for: .editingChanged)
        passwordReTextField.addTarget(self, action: #selector(handleTextChangeRePassword), for: .editingChanged)
    }
    
    //Method for handling text changes in textfield username --> used in targetTextfield Method
    //functionality heavily based on https://www.youtube.com/watch?v=mqaHpG1vPs8&list=PL_csAAO9PQ8buBXpnohnRyEbnYnXh81JE&index=1&t=676s
    @objc fileprivate func handleTextChangeUsername() {
        guard let text = usernameTextField.text else { return }
        
        switch iNumberValidityType {
        case .iNumber:
            if text.isValid(iNumberValidityType) {
                usernameTextField.layer.borderColor = Constants.General.green
                
                //Password Fields become available
                passwordTextField.isUserInteractionEnabled = true
                passwordReTextField.isUserInteractionEnabled = true
                passwordTextField.placeholder = "Password"
                registerButton.isEnabled = false
                
                //Remove Username Hint Text
                usernameLabel.text = ""
                configurePasswordLabel()
                
                //Reset other Textfields on Username changes to ensure Register Button can't be pressed
                passwordTextField.text = ""
                passwordReTextField.text = ""
                passwordTextField.layer.borderColor = Constants.General.gray
                passwordReTextField.layer.borderColor = Constants.General.gray
            } else {
                usernameTextField.layer.borderColor = Constants.General.red
                passwordTextField.isUserInteractionEnabled = false
                passwordReTextField.isUserInteractionEnabled = false
                passwordTextField.placeholder = Constants.Register.validUsername
                usernameLabel.text = Constants.Register.iNumberExample
                registerButton.isEnabled = false
            }
        default:
            do{}
        }
    }
    
    //Method for handling text changes in textfield password --> used in targetTextfield Method
    //functionality heavily based on https://www.youtube.com/watch?v=mqaHpG1vPs8&list=PL_csAAO9PQ8buBXpnohnRyEbnYnXh81JE&index=1&t=676s
    @objc fileprivate func handleTextChangePassword() {
        guard let text = passwordTextField.text else { return }
        
        switch pwdValidityType {
        
        case .password:
            if text.isValid(pwdValidityType) {
                passwordTextField.layer.borderColor = Constants.General.green
                //Password hint removed
                passwordLabel.text = ""
                
                //Reset other Textfields on Username changes to ensure Register Button can't be pressed
                passwordReTextField.text = ""
                registerButton.isEnabled = false
                passwordReTextField.layer.borderColor = Constants.General.gray
            } else {
                passwordTextField.layer.borderColor = Constants.General.red
                registerButton.isEnabled = false
                passwordLabel.text = Constants.Register.passwordExample
                
                //Reset other Textfields on Username changes to ensure Register Button can't be pressed
                passwordReTextField.text = ""
                passwordReTextField.layer.borderColor = Constants.General.gray
            }
        default:
        do{}
        }
    }
    
    //Method for handling text changes in textfield Re Password
    @objc fileprivate func handleTextChangeRePassword() {
        //Color of Re Password textfield based on if it has correct input
        if passwordReTextField.text == passwordTextField.text {
            passwordReTextField.layer.borderColor = Constants.General.green
            
            //Register Button becomes available to press
            registerButton.isEnabled = true
            
            //Show user that the UIPicker should be pressed
            selectClubLabel.textColor = UIColor.label
        } else {
            passwordReTextField.layer.borderColor = Constants.General.red
            registerButton.isEnabled = false
            selectClubLabel.textColor = UIColor.preferredFioriColor(forStyle: .criticalLabel)
        }
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

//MARK: - PickerView Datasource & Delegate Methods

extension RegisterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    //Datasource and Delegate for uiPicker
    func configureUIPicker() {
        clubPicker.dataSource = self
        clubPicker.delegate = self
    }
    
    //Method that returns number of rows each value has (in this case we only need one)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    //Method that returns the number of components the UIPicker should have.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        registerModel.clubNumbers.count
    }
    //Set the title for each row of the UIPicker
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "Club \(registerModel.clubNumbers[row])"
    }
   
    //Set the User selected club
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        club = registerModel.clubNumbers[row]
    }
    
}
