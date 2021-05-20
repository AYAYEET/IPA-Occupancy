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
    //Constant from the class RegexExtensions
    let pwdValidityType: String.ValidityType = .password

    
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
        targetTextfields()

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
    
    //MARK: - Methods for handling TextField changes and validating input
    
    fileprivate func targetTextfields() {
        newPasswordTextField.addTarget(self, action: #selector(handleTextChangePassword), for: .editingChanged)
        reNewPasswordTextField.addTarget(self, action: #selector(handleTextChangeRePassword), for: .editingChanged)
    }
    
    //Method for handling text changes in textfield newpassword --> used in targetTextfield Method
    //functionality heavily based on https://www.youtube.com/watch?v=mqaHpG1vPs8&list=PL_csAAO9PQ8buBXpnohnRyEbnYnXh81JE&index=1&t=676s
    //Same idea as RegisterVC, but more simple
    @objc fileprivate func handleTextChangePassword() {
        guard let text = newPasswordTextField.text else { return }
        
        switch pwdValidityType {
        case .password:
            if text.isValid(pwdValidityType) {
                newPasswordTextField.layer.borderColor = Constants.General.green
                reNewPasswordTextField.text = ""
                reNewPasswordTextField.isEnabled = true
            } else {
                newPasswordTextField.layer.borderColor = Constants.General.red
                reNewPasswordTextField.text = ""
                reNewPasswordTextField.isEnabled = true
            }
        default:
            do{}
        }
    }
    
    //Method for handling textchanges in textfield renewpassword
    @objc fileprivate func handleTextChangeRePassword() {
        if reNewPasswordTextField.text == newPasswordTextField.text {
            reNewPasswordTextField.layer.borderColor = Constants.General.green
            
            confirmButton.isEnabled = true
        } else {
            reNewPasswordTextField.layer.borderColor = Constants.General.red
            
            confirmButton.isEnabled = false
        }
    }
    
    //Method for returning TextFields to default look after a few seconds
    //Inspired by https://stackoverflow.com/questions/37801436/how-do-i-write-dispatch-after-gcd-in-swift-3-4-and-5
    fileprivate func resetColorOfTextfields() {
        DispatchQueue.main.asyncAfter(deadline: .now()+3.0 ) {

            self.newPasswordTextField.layer.borderColor = Constants.General.gray
            self.passwordTextField.layer.borderColor = Constants.General.gray
            self.reNewPasswordTextField.layer.borderColor = Constants.General.gray
        }
    }
}


