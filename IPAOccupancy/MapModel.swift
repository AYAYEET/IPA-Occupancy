//
//  MapModel.swift
//  IPAOccupancy
//
//  Created by Scheidegger, Jaden on 20.05.21.
//  Copyright © 2021 SAP. All rights reserved.
//

import Foundation
import UIKit
import SAPCommon
import SAPOData
import SAPFoundation

struct MapModel {
    
    //Total Booking space for each Club
    let club1Max = 16.0
    let club2Max = 10.0
    let club3Max = 16.0
    let club4Max = 16.0
    let club5Max = 12.0
    let club6Max = 16.0
    let club7Max = 16.0
    let club8Max = 12.0
    let occupancyMax = 114.0
    
    let serviceRoot = URL(string: Constants.General.odataURL)!
    let sapURLSession = SAPURLSession()
    
    //Method to get currently free values in each Club
    func getCurrentClubData(completionHandler: @escaping ([Int], String?) -> ()) {
        let odataProvider = OnlineODataProvider(serviceName: "EntityContainer", serviceRoot: serviceRoot, sapURLSession: sapURLSession)
        odataProvider.serviceOptions.checkVersion = false
        let dataService = EntityContainer(provider: odataProvider)
        let query = DataQuery()
            .select(Club.currentlyFree)
        do {
            //Do OData request
            dataService.fetchClub(matching: query) { club, error in
                if let error = error {
                    print(error.localizedDescription)
                    completionHandler([1], Constants.Map.connectionError)
                }
                if let allClubs = club {
                    //Create an array of all free space numbers
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
                    completionHandler(currentlyFreeArray, Constants.Map.success)
                }
            }
        }
    }
    
    //Method to get a percentage based on currentlyFree value.
    func calculatePercent(value: Int, maxValue: Double) -> Int {
        let valueAsDouble = Double(value)
        let doubleReturn = (100 / maxValue) * valueAsDouble
        let intReturn = 100 - doubleReturn
        return Int(intReturn)
    }
    //Method to set color based on currentlyFree value
    func calculateColor(value: Int, maxValue: Double) -> UIColor {
        let valueAsDouble = Double(value)
        let upToHalf = maxValue/2
        let upToEighty = maxValue/5
        //Decide which color is needed
        switch valueAsDouble {
        case upToHalf...maxValue:
            return UIColor.preferredFioriColor(forStyle: .positive)
        case upToEighty...upToHalf-0.1:
            return UIColor.preferredFioriColor(forStyle: .critical)
        case 0...upToEighty-0.1:
            return UIColor.preferredFioriColor(forStyle: .negative)
        default:
            return UIColor.black
        }
    }
}

struct MapTextModel {
    
    let serviceRoot = URL(string: Constants.General.odataURL)!
    let sapURLSession = SAPURLSession()
    
    //Method to check whether user has booked, if he has return the booked club
    func checkForBooked(username: String?, completionHandler: @escaping (String) -> ()) {
        
        let odataProvider = OnlineODataProvider(serviceName: "EntityContainer", serviceRoot: serviceRoot, sapURLSession: sapURLSession)
        odataProvider.serviceOptions.checkVersion = false
        let dataService = EntityContainer(provider: odataProvider)
        let query = DataQuery()
            .select(User.iUser, User.hasReserved, User.reservedClub)
            .filter(User.iUser.equal(username!))
        do {
            //Do OData request
            dataService.fetchUser(matching: query) { user, error in
                if let error = error {
                    print(error.localizedDescription)
                    completionHandler(Constants.Map.connectionError)
                    
                }
                if let oDataUser = user {
                    //Check if the user has reserved and return accordingly.
                    if oDataUser[0].hasReserved ?? false {
                        completionHandler(oDataUser[0].reservedClub ?? Constants.Map.notReserved)
                    } else {
                        completionHandler(Constants.Map.notReserved)
                    }  
                }
            }
        }
    }
}
