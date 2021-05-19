//
//  SettingsTableViewCell.swift
//  IPAOccupancy
//
//  Created by Scheidegger, Jaden on 19.05.21.
//  Copyright © 2021 SAP. All rights reserved.
//  Inspired by https://medium.com/@kemalekren/swift-create-custom-tableview-cell-with-programmatically-in-ios-835d3880513d

import Foundation
import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    static let identifier = Constants.Settings.settingsTableViewCell
    
    //MARK: - Components in Cell
    
    //Background for the icon to be displayed onto
    private let iconBackgroundView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8.0
        view.layer.masksToBounds = true
        return view
    }()
    
    //Image View for the icon
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //Label for Description of Setting
    private var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
}
