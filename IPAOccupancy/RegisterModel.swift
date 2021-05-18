//
//  RegisterModel.swift
//  IPAOccupancy
//
//  Created by Scheidegger, Jaden on 18.05.21.
//  Copyright © 2021 SAP. All rights reserved.
//

import UIKit
import SAPOData
import SAPFoundation
import SAPFiori

struct RegisterModel {
    
    let clubNumbers: [String] = ["1","2","3","4","5","6","7","8"]
    
    let serviceRoot = URL(string: Constants.General.odataURL)!
    let sapURLSession = SAPURLSession()
    
    func registerUser(usernameTextFieldData: String, passwordTextFieldData: String, clubPickerValie: String, completionHandler: @escaping (String) -> ()) {
        
    }
}
