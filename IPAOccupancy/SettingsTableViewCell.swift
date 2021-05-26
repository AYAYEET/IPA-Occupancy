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
    
    //MARK: - Initialization of the cell
    //Needed Method in a TableViewCell --> initialize the cell with all Subviews
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(iconBackgroundView)
        //iconImageView is inside BackgroundView
        iconBackgroundView.addSubview(iconImageView)
        contentView.addSubview(label)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    //Required Method for TableViewCell, handles possible error during init
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Subview Layout
    //Method for layout of Subview
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size: CGFloat = contentView.frame.height - 12
        //Location of background
        iconBackgroundView.frame = CGRect(x: 15, y: 6, width: size, height: size)
        
        //Icon is not as large as frame
        let imageSize:CGFloat = size / 1.5
        
        //Location of icon
        iconImageView.frame = CGRect(x: (size - imageSize)/2, y: (size - imageSize)/2, width: imageSize, height: imageSize)
        
        //Location of Label (Calculated with size of of Background in mind)
        label.frame = CGRect(
            x: 25 + iconBackgroundView.frame.size.width,
            y: 0,
            width: contentView.frame.size.width - 20 - iconBackgroundView.frame.size.width,
            height: contentView.frame.size.height
        )
    }
    
    //MARK: - Reuse of Cell
    //Method that gets called before each reuse of cell
    override func prepareForReuse() {
        super.prepareForReuse()
        iconBackgroundView.backgroundColor = nil
        iconImageView.image = nil
        label.text = nil
    }
    
    //MARK: - Tell Subview what data it will receive
    //Method for cell to know what data it will receive
    public func configureCell(model: SettingsRowModel) {
        iconBackgroundView.backgroundColor = model.iconBackgroundColor
        iconImageView.image = model.icon
        label.text = model.title      
    }
    
}
