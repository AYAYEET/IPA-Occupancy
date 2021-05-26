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
    //Array for UIPicker
    let clubNumbers: [String] = ["1","2","3","4","5","6","7","8"]
    
    let serviceRoot = URL(string: Constants.General.odataURL)!
    let sapURLSession = SAPURLSession()
    
    //Method for sending the Registration details to the oData Service
    func registerUser(usernameTextFieldData: String?, passwordTextFieldData: String?, clubPickerValue: String, completionHandler: @escaping (String) -> ()) {
        
        let odataProvider = OnlineODataProvider(serviceName: "EntityContainer", serviceRoot: serviceRoot, sapURLSession: sapURLSession)
        odataProvider.serviceOptions.checkVersion = false
        let dataService = EntityContainer(provider: odataProvider)
        let query = DataQuery()
            .select(User.iUser, User.password, User.status, User.prefferedClub, User.hasReserved)
            .top(1)
        do {
            //Do OData request
            dataService.fetchUser(matching: query) { user, error in
                if let error = error {
                    print(error.localizedDescription)
                    completionHandler(Constants.Register.connectionError)
                }
                //Set all needed values for the new user
                if let selectedUser = user {
                    let newUser = selectedUser.first?.copy()
                    newUser?.iUser = usernameTextFieldData
                    newUser?.password = passwordTextFieldData
                    newUser?.status = "new" // default status of a user when created
                    newUser?.prefferedClub = clubPickerValue
                    newUser?.hasReserved = false
                    
                    do {
                        //Create the User in the oData Service
                        try odataProvider.createEntity(newUser!, headers: .empty, options: .none)
                        completionHandler(Constants.Register.createSuccess)
                    } catch {
                        completionHandler(Constants.Register.createExists)
                    }
                }
            }
        }
    }
}
