//
//  MapFullViewController.swift
//  IPAOccupancy
//
//  Created by Scheidegger, Jaden on 21.05.21.
//  Copyright © 2021 SAP. All rights reserved.
//

import UIKit

class MapFullViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollView.delegate = self
        scrollView.maximumZoomScale = 5.0
        scrollView.minimumZoomScale = 1.0
    }
    
}

//MARK: - ScrollView Delegate Methods
extension MapFullViewController: UIScrollViewDelegate {
    //Method to tell ScrollView which View to scale when zoom gesture is used
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
