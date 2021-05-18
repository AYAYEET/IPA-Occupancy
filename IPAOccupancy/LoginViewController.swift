//
//  LoginViewController.swift
//  IPAOccupancy
//
//  Created by Scheidegger, Jaden on 18.05.21.
//  Copyright © 2021 SAP. All rights reserved.
//

import UIKit
import SAPFiori

class LoginViewController: UIViewController {

    //instantiate loginModel
    let loginModel = LoginModel()

    
    //IBOutlets connected to Login.storyboard
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
    }
    
    //What happens when Login Button is pressed
    @IBAction func loginPressed(_ sender: UIButton) {
        //call to verifyLogin Method from model pass username and password and handle results based on completion handler
        loginModel.verifyLogin(usernameTextFieldData: usernameTextField.text, passwordTextFieldData: passwordTextField.text) { (loginStatus, username) in
            
            switch loginStatus {
            case Constants.Login.connectionError:
                //FUI Design Elements
                FUIToastMessage.show(message: "Connection Error, try again",
                                             icon: UIImage(systemName: "exclamationmark.circle")!,
                                             inView: self.messageView,
                                             withDuration: 2.0,
                                             maxNumberOfLines: 0)
            case Constants.Login.emptyUsername:
                self.usernameTextField.layer.borderColor = Constants.General.red
                self.passwordTextField.layer.borderColor = Constants.General.red
            
            case Constants.Login.notEmptyUsername:
                self.usernameTextField.layer.borderColor = Constants.General.green
                
            case Constants.Login.passwordIsEmpty:
                self.passwordTextField.layer.borderColor = Constants.General.red
            
            case Constants.Login.notEmptyPassword:
                self.passwordTextField.layer.borderColor = Constants.General.green
                
            case Constants.Login.userIsNew:
                FUIToastMessage.show(message: "User has not been accepted yet.",
                                             icon: UIImage(systemName: "exclamationmark.circle")!,
                                             inView: self.messageView,
                                             withDuration: 2.0,
                                             maxNumberOfLines: 0)
            case Constants.Login.userIsBlocked:
                FUIToastMessage.show(message: "User has been blocked.",
                                             icon: UIImage(systemName: "exclamationmark.circle")!,
                                             inView: self.messageView,
                                             withDuration: 2.0,
                                             maxNumberOfLines: 0)
                
            case Constants.Login.userIsDeleted:
                FUIToastMessage.show(message: "User has been deleted.",
                                             icon: UIImage(systemName: "exclamationmark.circle")!,
                                             inView: self.messageView,
                                             withDuration: 2.0,
                                             maxNumberOfLines: 0)
                
            case Constants.Login.userIsFree:
                print("success")

            default:
                FUIToastMessage.show(message: "Something went wrong.",
                                             icon: UIImage(systemName: "exclamationmark.circle")!,
                                             inView: self.messageView,
                                             withDuration: 2.0,
                                             maxNumberOfLines: 0)
            }
        }
    }
    
    //What happens when Register Button is pressed
    @IBAction func registerPressed(_ sender: UIButton) {
    }
    
    // MARK: - Navigation
    //navigation preparation
    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        switch segue.identifier {
        case "loginSegue":
        print()
        case "registerSegue":
            print()
        default:
            print("no segue")
        }
    }
    
    //MARK: - Button Styling (Mostly done in Storyboard)
        //Changes to the design of Button
        fileprivate func configureButtons() {
            loginButton.layer.cornerRadius = 5
            registerButton.layer.cornerRadius = 5
        }
    
    //MARK: - Textfield styling (Mostly done in Storyboard)
    fileprivate func configureTextFields() {
        usernameTextField.layer.borderWidth = 1.0
        passwordTextField.layer.borderWidth = 1.0
        usernameTextField.layer.cornerRadius = 5
        passwordTextField.layer.cornerRadius = 5
        //color choice is based on fiori guidelines
        usernameTextField.layer.borderColor = UIColor.preferredFioriColor(forStyle: .primary9).cgColor
        passwordTextField.layer.borderColor = UIColor.preferredFioriColor(forStyle: .primary9).cgColor
    }
    
}
