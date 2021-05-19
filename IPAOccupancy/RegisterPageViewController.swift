//
//  RegisterPageViewController.swift
//  IPAOccupancy
//
//  Created by Scheidegger, Jaden on 18.05.21.
//  Copyright © 2021 SAP. All rights reserved.
//

import UIKit

class RegisterPageViewController: UIPageViewController {

    //Creates an Array of View Controllers from the Register Storyboard for use in this PageViewController
    lazy var subViewControllers: [UIViewController] = {
        return [
            UIStoryboard(name: "Register", bundle: nil).instantiateViewController(identifier: "Onboarding1ViewController") as! Onboarding1ViewController,
            UIStoryboard(name: "Register", bundle: nil).instantiateViewController(identifier: "Onboarding2ViewController") as! Onboarding2ViewController,
            UIStoryboard(name: "Register", bundle: nil).instantiateViewController(identifier: "Onboarding3ViewController") as! Onboarding3ViewController,
            UIStoryboard(name: "Register", bundle: nil).instantiateViewController(identifier: "RegisterViewController") as! RegisterViewController
        ]
    }()
    
    let pageControl = UIPageControl()
    let firstPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sourcesPageViewControl()
        pageControlStyle()
        pageControlLayout()
        
        
        
  
        
       
    }
    
    //MARK: - PageControl Styling & Setup
    //Method for basic traits of PageControl
    func pageControlStyle() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .tertiarySystemFill
        pageControl.pageIndicatorTintColor = .systemGray2
        pageControl.numberOfPages = subViewControllers.count
        pageControl.currentPage = firstPage
    }
    
    //Method for adding PageControlLayout to the view<<<
    func pageControlLayout() {
        view.addSubview(pageControl)
        //Inspired by https://www.youtube.com/watch?v=a5yjOMLBfSc
        NSLayoutConstraint.activate([
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 100),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: pageControl.bottomAnchor, multiplier: 1),
        ])
    }

    //MARK: - Set Datasource & Delegate
    //Method for settings Datasource and Delegate of PageViewController
    func sourcesPageViewControl() {
        dataSource = self
        delegate = self
        //How to display VC
        setViewControllers([subViewControllers[0]], direction: .forward, animated: true, completion: nil)

    }
    
}

//MARK: - Extension to UIPageViewControllerDataSource
//Help needed here from Apple Docs https://developer.apple.com/documentation/uikit/uipageviewcontroller
extension RegisterPageViewController: UIPageViewControllerDataSource {
    
    //Method to tell PageViewController how many views it has (mandatory)
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewControllers.count
    }
    
    //Method to tell PageViewController which view comes when swiped back (mandatory)
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentPageView = subViewControllers.firstIndex(of: viewController) else { return nil }
        if currentPageView <= 0 {
            return nil
        }
        return subViewControllers[currentPageView - 1]
    }
    
    //Method to tell PageViewController which view comes when swiped forward (mandatory)
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentPageView = subViewControllers.firstIndex(of: viewController) else { return nil }
        if currentPageView >= subViewControllers.count - 1{
            return nil
        }
        return subViewControllers[currentPageView + 1]
    }
}

//MARK: - Extension to UIPageViewControllerDataSource
extension RegisterPageViewController: UIPageViewControllerDelegate {
    
    //Method to keep pageControl in sync with PageViewController (gets called after swipe, updates value for pageControl)
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentPageView = subViewControllers.firstIndex(of: viewControllers[0]) else { return }
        
        pageControl.currentPage = currentPageView

    }
}
