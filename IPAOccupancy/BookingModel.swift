//
//  BookingModel.swift
//  IPAOccupancy
//
//  Created by Scheidegger, Jaden on 21.05.21.
//  Copyright © 2021 SAP. All rights reserved.
//

import Foundation
import UIKit
import SAPCommon
import SAPOData
import SAPFoundation

struct BookingModel {
    
    let serviceRoot = URL(string: Constants.General.odataURL)!
    let sapURLSession = SAPURLSession()
    
    //Method to get currently free values in each Club (Same Method as in MapModel)
    func getCurrentClubData(completionHandler: @escaping ([Int], String?) -> ()) {
        let odataProvider = OnlineODataProvider(serviceName: "EntityContainer", serviceRoot: serviceRoot, sapURLSession: sapURLSession)
        odataProvider.serviceOptions.checkVersion = false
        let dataService = EntityContainer(provider: odataProvider)
        let query = DataQuery()
            .select(Club.currentlyFree)
            
        do {
            dataService.fetchClub(matching: query) { club, error in
                if let error = error {
                    print(error.localizedDescription)
                    completionHandler([1], Constants.Booking.connectionError)
                }
                if let allClubs = club {
                    let currentlyFreeArray = [
                        allClubs[0].currentlyFree!,
                        allClubs[1].currentlyFree!,
                        allClubs[2].currentlyFree!,
                        allClubs[3].currentlyFree!,
                        allClubs[4].currentlyFree!,
                        allClubs[5].currentlyFree!,
                        allClubs[6].currentlyFree!,
                        allClubs[7].currentlyFree!
                    ]
                    completionHandler(currentlyFreeArray, Constants.Booking.success)
                    
                }
            }
        }
    }
}

struct BookingReserveModel {
    
    let serviceRoot = URL(string: Constants.General.odataURL)!
    let sapURLSession = SAPURLSession()
    
    //Method to get currently Users preferred club and reserved club
    func getUserClubReservation(username: String?, completionHandler: @escaping (String, String, Bool) -> ()) {
        
        let odataProvider = OnlineODataProvider(serviceName: "EntityContainer", serviceRoot: serviceRoot, sapURLSession: sapURLSession)
        odataProvider.serviceOptions.checkVersion = false
        let dataService = EntityContainer(provider: odataProvider)
        let query = DataQuery()
            .select(User.prefferedClub,User.reservedClub, User.hasReserved)
            .filter(User.iUser.equal(username!)) //there will always be a username
        
        do {
            dataService.fetchUser(matching: query) { user, error in
                if let error = error {
                    print(error.localizedDescription)
                    //Value true to ensure booking isn't possible if there is a conneciton problem.
                    completionHandler(Constants.Booking.connectionError, "", true)
                }
                if let oDataUser = user {
                    completionHandler(oDataUser[0].prefferedClub ?? "1",oDataUser[0].reservedClub ?? "1", oDataUser[0].hasReserved ?? true)
                }
            }
        }
    }
    
    //Uses preferred club of user to to check for available space in that club
    func getFreeInPreferredClub(prefferedClub: String, completionHandler: @escaping (Int?, String) -> ()) {
        let odataProvider = OnlineODataProvider(serviceName: "EntityContainer", serviceRoot: serviceRoot, sapURLSession: sapURLSession)
        odataProvider.serviceOptions.checkVersion = false
        let dataService = EntityContainer(provider: odataProvider)
        let query = DataQuery()
            .select(Club.currentlyFree)
            .filter(Club.clubName.equal(prefferedClub))
        
        do {
            dataService.fetchClub(matching: query) { club, error in
                if let error = error {
                    print(error.localizedDescription)
                    completionHandler(1,Constants.Booking.connectionError)
                }
                if let prefferedClub = club {
                    completionHandler(prefferedClub[0].currentlyFree ?? 1, Constants.Booking.success)
                }
            }
        }
    }
}
