//
//  RegexExtensions.swift
//  IPAOccupancy
//
//  Created by Scheidegger, Jaden on 18.05.21.
//  Copyright © 2021 SAP. All rights reserved.
//  Class for creating REGEX cases for textfields based on video https://www.youtube.com/watch?v=mqaHpG1vPs8&list=PL_csAAO9PQ8buBXpnohnRyEbnYnXh81JE&index=1&t=676s

import Foundation

extension String {
    
    enum ValidityType {
        case iNumber
        case password
    }
    
    enum Regex: String {
        case iNumber = "^i[0-9]{7,7}+$"
        case password = "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]).{3,25}$" //one uppercase, one symbol, one number, one lowercase
       

    }
    //Method for checking if Regex matches text
    func isValid(_ validityType: ValidityType) -> Bool {
        let format = "SELF MATCHES %@"
        var regex = ""
        
        switch validityType {
        case .iNumber:
            regex = Regex.iNumber.rawValue
        case .password:
            regex = Regex.password.rawValue
 
        }
        
        return NSPredicate(format: format, regex).evaluate(with: self)
        
    }
}
