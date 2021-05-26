//
//  LoginViewController.swift
//  IPAOccupancy
//
//  Created by Scheidegger, Jaden on 18.05.21.
//  Copyright © 2021 SAP. All rights reserved.
//

import UIKit
import SAPFiori
import SAPCommon

class LoginViewController: UIViewController {
    
    //Instantiate loginModel
    let loginModel = LoginModel()
    
    //Variable to carry over to MainVC during segue
    var CarryOverUsername: String?
    
    
    //Storyboard Connections
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var messageView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configureButtons()
        configureTextFields()
        delegateTextFields()
    }
    
    //What happens when Login Button is pressed
    @IBAction func loginPressed(_ sender: UIButton) {
        //Call to verifyLogin Method from model pass username and password and handle results based on completion handler
        loginModel.verifyLogin(usernameTextFieldData: usernameTextField.text, passwordTextFieldData: passwordTextField.text) { (loginStatus, username) in
            //How to handle each return
            switch loginStatus {
            case Constants.Login.connectionError:
                //FUI Design Elements
                FUIToastMessage.show(message: "Connection Error, try again",
                                     icon: UIImage(systemName: "exclamationmark.circle")!,
                                     inView: self.messageView,
                                     withDuration: 2.0,
                                     maxNumberOfLines: 1)
                
            case Constants.Login.emptyUsername:
                self.usernameTextField.layer.borderColor = Constants.General.red
                self.passwordTextField.layer.borderColor = Constants.General.red
                self.resetColorOfTextfields()
                
                
            case Constants.Login.notEmptyUsername:
                self.usernameTextField.layer.borderColor = Constants.General.green
                self.resetColorOfTextfields()
                
                
            case Constants.Login.passwordIsEmpty:
                self.passwordTextField.layer.borderColor = Constants.General.red
                self.resetColorOfTextfields()
                
                
            case Constants.Login.notEmptyPassword:
                self.passwordTextField.layer.borderColor = Constants.General.green
                self.resetColorOfTextfields()
                
                
            case Constants.Login.userIsNew:
                FUIToastMessage.show(message: "User has not been accepted yet.",
                                     icon: UIImage(systemName: "exclamationmark.circle")!,
                                     inView: self.messageView,
                                     withDuration: 2.0,
                                     maxNumberOfLines: 2)
                self.resetColorOfTextfields()
                
                
            case Constants.Login.userIsBlocked:
                FUIToastMessage.show(message: "User has been blocked.",
                                     icon: UIImage(systemName: "exclamationmark.circle")!,
                                     inView: self.messageView,
                                     withDuration: 2.0,
                                     maxNumberOfLines: 1)
                self.resetColorOfTextfields()
                
                
            case Constants.Login.userIsDeleted:
                FUIToastMessage.show(message: "User has been deleted.",
                                     icon: UIImage(systemName: "exclamationmark.circle")!,
                                     inView: self.messageView,
                                     withDuration: 2.0,
                                     maxNumberOfLines: 1)
                self.resetColorOfTextfields()
                
                
            case Constants.Login.userIsFree:
                //Setting userdefaults for decision between login and main at app launch --> Here true
                UserDefaults.standard.set(true, forKey: "status")
                //Set our username for the TabBarViewController
                self.CarryOverUsername = username
                //Segue to Main
                self.performSegue(withIdentifier: Constants.Login.loginSegue, sender: self)
                
            default:
                FUIToastMessage.show(message: "Something went wrong.",
                                     icon: UIImage(systemName: "exclamationmark.circle")!,
                                     inView: self.messageView,
                                     withDuration: 2.0,
                                     maxNumberOfLines: 0)
                self.resetColorOfTextfields()
                
            }
        }
    }
    
    //What happens when Register Button is pressed
    @IBAction func registerPressed(_ sender: UIButton) {
        //Segue to Register
        self.performSegue(withIdentifier: Constants.Login.registerSegue, sender: self)
        
    }
    
    // MARK: - Navigation
    //Navigation preparation
    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        switch segue.identifier {
        case Constants.Login.loginSegue:
            //When Login happens, send username to the TabBarViewController
            let destinationVC = segue.destination as! TabBarViewController
            
            destinationVC.username = CarryOverUsername
        case Constants.Login.registerSegue:
            do{}
        default:
            do{}
        }
    }
    
    //MARK: - Button Styling (Mostly done in Storyboard)
    //Changes the design of Button
    func configureButtons() {
        loginButton.layer.cornerRadius = 5
        registerButton.layer.cornerRadius = 5
    }
    
    //MARK: - Textfield styling (Mostly done in Storyboard)
    //Changes the design of Textfields
    func configureTextFields() {
        usernameTextField.layer.borderWidth = 1.0
        passwordTextField.layer.borderWidth = 1.0
        usernameTextField.layer.cornerRadius = 5
        passwordTextField.layer.cornerRadius = 5
        //Color choice is based on fiori guidelines
        usernameTextField.layer.borderColor = UIColor.preferredFioriColor(forStyle: .primary9).cgColor
        passwordTextField.layer.borderColor = UIColor.preferredFioriColor(forStyle: .primary9).cgColor
    }
    
    //Method for returning TextFields to default look after a few seconds
    func resetColorOfTextfields() {
        DispatchQueue.main.asyncAfter(deadline: .now()+3.0 ) {
            
            self.usernameTextField.layer.borderColor = Constants.General.gray
            self.passwordTextField.layer.borderColor = Constants.General.gray
        }
    }
}

//MARK: - UITextfield Delegate Methods
extension LoginViewController: UITextFieldDelegate {
    //Set delegate for textfields
    func delegateTextFields() {
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
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
            
        default:
            self.passwordTextField.resignFirstResponder()
        }
    }
}
