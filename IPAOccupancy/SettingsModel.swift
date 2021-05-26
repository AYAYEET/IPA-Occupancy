//
//  SettingsModel.swift
//  IPAOccupancy
//
//  Created by Scheidegger, Jaden on 19.05.21.
//  Copyright © 2021 SAP. All rights reserved.
//

import Foundation
import UIKit
import SAPCommon
import SAPOData
import SAPFoundation

//Model for the SettingsTableViewCell
struct SettingsRowModel {
    
    let iconBackgroundColor: UIColor
    let icon: UIImage?
    let title: String
    
    //Allow for an action to be assigned to cell
    let action: (() -> Void)
}

struct SettingsClubModel {
    
    //Array for UIPicker
    let clubNumbers: [String] = ["1","2","3","4","5","6","7","8"]
    
    let serviceRoot = URL(string: Constants.General.odataURL)!
    let sapURLSession = SAPURLSession()
    
    //Method for getting the current preferred Club of the user
    func getCurrentClub(username: String?, completionHandler: @escaping (String) -> ()) {
        
        let odataProvider = OnlineODataProvider(serviceName: "EntityContainer", serviceRoot: serviceRoot, sapURLSession: sapURLSession)
        odataProvider.serviceOptions.checkVersion = false
        let dataService = EntityContainer(provider: odataProvider)
        let query = DataQuery()
            .select(User.iUser, User.prefferedClub)
            .filter(User.iUser.equal(username!))
        do {
            //Do OData request
            dataService.fetchUser(matching: query) { user, error in
                if let error = error {
                    print(error.localizedDescription)
                    completionHandler(Constants.Settings.connectionError)
                }
                if let oDataUser = user {
                    if let club = oDataUser[0].prefferedClub {
                    completionHandler(club)
                    } else {
                        completionHandler(Constants.Settings.error)
                    }
                    
                }
            }
        }
    
    }
    //Method to set the newly selected Club of the User
    func setCurrentClub(username: String?,club: String?, completionHandler: @escaping (String) -> ()) {
        let odataProvider = OnlineODataProvider(serviceName: "EntityContainer", serviceRoot: serviceRoot, sapURLSession: sapURLSession)
        odataProvider.serviceOptions.checkVersion = false
        let dataService = EntityContainer(provider: odataProvider)
        let query = DataQuery()
            .select(User.iUser, User.prefferedClub)
            .filter(User.iUser.equal(username!))
            .top(1)
        
        do {
            //Do OData request
            dataService.fetchUser(matching: query) { user, error in
                if let error = error {
                    print(error.localizedDescription)
                    completionHandler(Constants.Settings.connectionError)
                }
                if let oDataUser = user {
                    //Set new club
                    oDataUser[0].prefferedClub = club
                    do {
                        //Update Club
                        try odataProvider.updateEntity(oDataUser[0], headers: .empty, options: .none)
                        completionHandler(Constants.Settings.updateSuccess)
                    } catch {
                        completionHandler(Constants.Settings.updateFailed)
                    }
                }
            }
        }
    }
}

struct SettingsAccountModel {
    
    let serviceRoot = URL(string: Constants.General.odataURL)!
    let sapURLSession = SAPURLSession()
    
    //Method for updating Password of User and ensuring the given password is equal to the old password
    func updatePassword(username: String?, previousPassword: String?, newPassword: String, completionHandler: @escaping (String) -> ()) {
        let odataProvider = OnlineODataProvider(serviceName: "EntityContainer", serviceRoot: serviceRoot, sapURLSession: sapURLSession)
        odataProvider.serviceOptions.checkVersion = false
        let dataService = EntityContainer(provider: odataProvider)
        let query = DataQuery()
            .select(User.iUser, User.password)
            .filter(User.iUser.equal(username!))
            .top(1)
        do {
            //Do OData Request
            dataService.fetchUser(matching: query) { user, error in
                if let error = error {
                    print(error.localizedDescription)
                    completionHandler(Constants.Settings.connectionError)
                }
                if let oDataUser = user {
                    //Check old password of user first
                    if oDataUser[0].password != previousPassword {
                        completionHandler(Constants.Settings.previousPasswordIncorrect)
                    } else {
                        oDataUser[0].password = newPassword
                        
                        do {
                            try odataProvider.updateEntity(oDataUser[0], headers: .empty, options: .none)
                            completionHandler(Constants.Settings.updateSuccess)
                        } catch {
                            completionHandler(Constants.Settings.updateFailed)
                        }
                        
                    }
                }
            }
        }
    }
}
