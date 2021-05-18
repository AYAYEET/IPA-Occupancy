//
//  LoginModel.swift
//  IPAOccupancy
//
//  Created by Scheidegger, Jaden on 18.05.21.
//  Copyright © 2021 SAP. All rights reserved.
//

import SAPFoundation
import SAPOData
import UIKit
import SAPFiori

struct LoginModel {
    //url for knowing where the oData service is
    let serviceRoot = URL(string: "https://ims-ch-ims-ims-ch-cf-2021-ipa-booking-srv.cfapps.eu10.hana.ondemand.com/catalog")!
    //oData optimized version of URLSession
    let sapURLSession = SAPURLSession()
    
    //Method to verify Textfields and decide if user can be logged in
    func verifyLogin(usernameTextFieldData: String?,passwordTextFieldData: String?, completionHandler: @escaping (String, String?) -> ()) {
        var returnValue = Constants.Login.defaultReturnValue
        var userName: String?
        
        let odataProvider = OnlineODataProvider(serviceName: "EntityContainer", serviceRoot: serviceRoot, sapURLSession: sapURLSession)
        odataProvider.serviceOptions.checkVersion = false
        
        let dataService = EntityContainer(provider: odataProvider)
        //Data Queries
        let userQuery = DataQuery()
            .select(User.iUser)
            .filter(User.iUser.toLower().equal(usernameTextFieldData ?? "none"))
        let passwordQuery = DataQuery()
            .select(User.password, User.iUser, User.status)
            .filter(User.password.equal(passwordTextFieldData ?? "none"))
            .filter(User.iUser.toLower().equal(usernameTextFieldData!))
        
        do {
            dataService.fetchUser(matching: userQuery) { user, error in
                if let error = error {
                    //this only ever happens when an actual connection error occurs
                    returnValue = Constants.Login.connectionError
                    print(error.localizedDescription)
                    completionHandler(returnValue, userName)
                }
                if let selectedUsername = user {
                    if selectedUsername.isEmpty == true {
                        returnValue = Constants.Login.emptyUsername
                        completionHandler(returnValue, userName)
                        
                    } else if selectedUsername.isEmpty != true {
                        returnValue = Constants.Login.notEmptyUsername
                        completionHandler(returnValue, userName)
                        
                        //this only happens when the username is correct
                        do {
                            dataService.fetchUser(matching: passwordQuery) { user, error in
                                if let error = error {
                                    returnValue = Constants.Login.connectionError
                                    print(error.localizedDescription)
                                    completionHandler(returnValue, userName)
                                }
                                if let selectedUserPassword = user {
                                    if selectedUserPassword.isEmpty == true {
                                        returnValue = Constants.Login.passwordIsEmpty
                                        completionHandler(returnValue, userName)
                                        
                                    } else if selectedUserPassword.isEmpty != true {
                                        returnValue = Constants.Login.notEmptyPassword
                                        completionHandler(returnValue, userName)
                                        
                                        //check for current status of user before allowing login
                                        switch selectedUserPassword[0].status {
                                        case Constants.Login.userStatusNew:
                                            returnValue = Constants.Login.userIsNew
                                            completionHandler(returnValue, userName)
                                            
                                        case Constants.Login.userStatusBlocked:
                                            returnValue = Constants.Login.userIsBlocked
                                            completionHandler(returnValue, userName)
                                            
                                        case Constants.Login.userStatusDeleted:
                                            returnValue = Constants.Login.userIsDeleted
                                            completionHandler(returnValue, userName)
                                            
                                        case Constants.Login.userStatusFree:
                                            //login is successful
                                            returnValue = Constants.Login.userIsFree
                                            //set the username to the definite name from the service
                                            userName = selectedUserPassword[0].iUser
                                            completionHandler(returnValue, userName)
                                            
                                        default:
                                            returnValue = Constants.Login.connectionError
                                            completionHandler(returnValue, userName)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
