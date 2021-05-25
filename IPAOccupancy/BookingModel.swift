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
    //Method to book space in preferred Club and ensure Club is not full
    func bookpreferredClub(preferredClub: String, username: String?, completionHandler: @escaping (String) -> ()) {
        let odataProvider = OnlineODataProvider(serviceName: "EntityContainer", serviceRoot: serviceRoot, sapURLSession: sapURLSession)
        odataProvider.serviceOptions.checkVersion = false
        let dataService = EntityContainer(provider: odataProvider)
        let queryUser = DataQuery()
            .select(User.iUser, User.hasReserved, User.reservedClub, User.prefferedClub)
            .filter(User.iUser.equal(username!)) //username exists
        let queryClub = DataQuery()
            .select(Club.currentlyFree)
            .filter(Club.clubName.equal(preferredClub))
        
        do {
            dataService.fetchUser(matching: queryUser) { user, error in
                if let error = error {
                    print(error.localizedDescription)
                    completionHandler(Constants.Booking.connectionError)
                }
                if let oDataUser = user {
                   
                    oDataUser[0].hasReserved = true
                    oDataUser[0].reservedClub = oDataUser[0].prefferedClub
                    //Ensure Club is not full
                    dataService.fetchClub(matching: queryClub) { club, error in
                        if let error = error {
                            print(error.localizedDescription)
                            completionHandler(Constants.Booking.connectionError)
                        }
                        //Testcase warned about this in advance ;)
                        if let oDataClub = club {
                            if oDataClub[0].currentlyFree! == 0 {
                                completionHandler(Constants.Booking.fullClub)
                            } else {
                            oDataClub[0].currentlyFree! -= 1
                                
                                do {
                                    try odataProvider.updateEntity(oDataClub[0], headers: .empty, options: .none)
                                } catch {
                                    completionHandler(Constants.Booking.failed)
                                }
                                do {
                                    try odataProvider.updateEntity(oDataUser[0], headers: .empty, options: .none)
                                    completionHandler(Constants.Booking.success)
                                } catch {
                                    completionHandler(Constants.Booking.failed)
                                }
                            }

                        }
                    }

                }
            }
        }
    }
    //Method to cancel booking
    func cancelBookClub(reservedClub: String, username: String?, completionHandler: @escaping (String) -> ()) {
        let odataProvider = OnlineODataProvider(serviceName: "EntityContainer", serviceRoot: serviceRoot, sapURLSession: sapURLSession)
        odataProvider.serviceOptions.checkVersion = false
        let dataService = EntityContainer(provider: odataProvider)
        let queryUser = DataQuery()
            .select(User.iUser, User.hasReserved, User.reservedClub, User.prefferedClub)
            .filter(User.iUser.equal(username!)) //username exists
        let queryClub = DataQuery()
            .select(Club.currentlyFree)
            .filter(Club.clubName.equal(reservedClub))
        
        do {
            dataService.fetchUser(matching: queryUser) { user, error in
                if let error = error {
                    print(error.localizedDescription)
                    completionHandler(Constants.Booking.connectionError)
                }
                if let oDataUser = user {
                    oDataUser[0].hasReserved = false
                    oDataUser[0].reservedClub = ""
                    
                    //Update Club free spaces
                    dataService.fetchClub(matching: queryClub) { club, error in
                        if let error = error {
                            print(error.localizedDescription)
                            completionHandler(Constants.Booking.connectionError)
                        }
                        if let oDataClub = club {
                            oDataClub[0].currentlyFree! += 1
                            do {
                                try odataProvider.updateEntity(oDataClub[0], headers: .empty, options: .none)
                            } catch {
                                completionHandler(Constants.Booking.failed)
                            }
                        }
                    }
                    do {
                        try odataProvider.updateEntity(oDataUser[0], headers: .empty, options: .none)
                        completionHandler(Constants.Booking.success)
                    } catch {
                        completionHandler(Constants.Booking.failed)
                    }
                }
            }
        }
    }
    
    //Method to book space in random Club and ensure Club is not full
    func bookrandomClub(username: String?, completionHandler: @escaping (String) -> ()) {
        let odataProvider = OnlineODataProvider(serviceName: "EntityContainer", serviceRoot: serviceRoot, sapURLSession: sapURLSession)
        odataProvider.serviceOptions.checkVersion = false
        let dataService = EntityContainer(provider: odataProvider)
        let queryUser = DataQuery()
            .select(User.iUser, User.hasReserved, User.reservedClub, User.prefferedClub)
            .filter(User.iUser.equal(username!)) //username exists
        let queryClub = DataQuery()
            .select(Club.currentlyFree)
        
        var randomClub = Int.random(in: 0...7)
        var maxTries = 0
        do {
            dataService.fetchUser(matching: queryUser) { user, error in
                if let error = error {
                    print(error.localizedDescription)
                    completionHandler(Constants.Booking.connectionError)
                }
                if let oDataUser = user {
                                       
                    //Ensure Club is not full
                    dataService.fetchClub(matching: queryClub) { club, error in
                        if let error = error {
                            print(error.localizedDescription)
                            completionHandler(Constants.Booking.connectionError)
                        }
                        //If the random club is not free try another
                        if let oDataClub = club {
                            while oDataClub[randomClub].currentlyFree! == 0 {
                                randomClub += 1
                                if randomClub == 8 && maxTries == 0 {
                                    randomClub = 1
                                    maxTries += 1
                                } else {
                                    completionHandler(Constants.Booking.noneFree)
                                }
                            }
                            oDataClub[randomClub].currentlyFree! -= 1
                            oDataUser[0].reservedClub = String(randomClub + 1)
                            oDataUser[0].hasReserved = true

                                do {
                                    try odataProvider.updateEntity(oDataClub[randomClub], headers: .empty, options: .none)
                                    print("OMGLOL \(oDataClub[randomClub])")
                                } catch {
                                    completionHandler(Constants.Booking.failed)
                                }
                                do {
                                    try odataProvider.updateEntity(oDataUser[0], headers: .empty, options: .none)
                                    completionHandler(Constants.Booking.success)
                                } catch {
                                    completionHandler(Constants.Booking.failed)
                                }
                            }

                        }
                    }

                }
            }
    }
}
