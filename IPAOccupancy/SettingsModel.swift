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
