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
            .filter(User.iUser.equal(username!)) //there will always be a username
            
        do {
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
    //Method to set the newly selected club of the User
    func setCurrentClub(username: String?,club: String?, completionHandler: @escaping (String) -> ()) {
        let odataProvider = OnlineODataProvider(serviceName: "EntityContainer", serviceRoot: serviceRoot, sapURLSession: sapURLSession)
        odataProvider.serviceOptions.checkVersion = false
        let dataService = EntityContainer(provider: odataProvider)
        let query = DataQuery()
            .select(User.iUser, User.prefferedClub)
            .filter(User.iUser.equal(username!)) //there will always be a username
            .top(1)
        
        do {
            dataService.fetchUser(matching: query) { user, error in
                if let error = error {
                    print(error.localizedDescription)
                    completionHandler(Constants.Settings.connectionError)
                }
                if let oDataUser = user {
                    oDataUser[0].prefferedClub = club
                    do {
                        //Update the current Users club using method provided by iOS SDK
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
