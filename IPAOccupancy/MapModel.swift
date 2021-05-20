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
            dataService.fetchClub(matching: query) { club, error in
                if let error = error {
                    print(error.localizedDescription)
                    completionHandler([1], Constants.Map.connectionError)
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
                    completionHandler(currentlyFreeArray, Constants.Map.success)
                    
                }
            }
        }
    }
}
