//
//  Constants.swift
//  IPAOccupancy
//
//  Created by Scheidegger, Jaden on 18.05.21.
//  Copyright © 2021 SAP. All rights reserved.
//  A Class for Strings that are used more than once.

import Foundation
import UIKit

struct Constants {
    //constants that are for general use within the application
    struct General {
        static let odataURL = "https://ims-ch-ims-ims-ch-cf-2021-ipa-booking-srv.cfapps.eu10.hana.ondemand.com/catalog"
        //Fiori Colors for red green and gray
        static let gray = UIColor.preferredFioriColor(forStyle: .primary9).cgColor
        static let red = UIColor.preferredFioriColor(forStyle: .negative).cgColor
        static let green = UIColor.preferredFioriColor(forStyle: .positive).cgColor
    }
    
    struct Login {
        static let defaultReturnValue = "DefaultReturn"
        static let connectionError = "ConnectionError"
        static let connectionErrorMessage = "An error occured fetching Data"
        static let emptyUsername = "UsernameIsEmpty"
        static let notEmptyUsername = "UsernameIsNotEmpty"
        static let passwordIsEmpty = "PasswordIsEmpty"
        static let notEmptyPassword = "PasswordIsNotEmpty"
        static let userIsNew = "UserIsNew"
        static let userIsBlocked = "UserIsBlocked"
        static let userIsDeleted = "UserIsDeleted"
        static let userIsFree = "UserIsFree"
        //login segues
        static let loginSegue = "loginSegue"
        static let registerSegue = "registerSegue"
        //status of users
        static let userStatusNew = "new"
        static let userStatusBlocked = "Gesperrt"
        static let userStatusFree = "Freigegeben"
        static let userStatusDeleted = "Deleted"
    }
    
    struct Register {
        
        static let validUsername = "Please Enter a valid i-Number above first"
        static let passwordExample = "Must contain at least one: UPPERCASE, LOWERCASE, \nNumber & Special Character Example: Sa123*"
        static let iNumberExample = "i-Number example: i45043"
        static let createSuccess = "success"
        static let createExists = "exists"
        static let connectionError = "ConnectionError"

    }
    
}
