//
//  BaseViewController.swift
//  Spotify
//
//  Created by Jhonnatan Macias on 7/11/18.
//  Copyright © 2018 Jhonnatan Macias. All rights reserved.
//

import UIKit
import Foundation

class BaseViewController: UIViewController {
    
    
    private var rightView                   : UIView!
    internal var spinner                    : UIActivityIndicatorView!
    internal var spinnerView                : UIView!
    
    fileprivate var spinnerCount : Int = 0 {
        didSet{
            if spinnerCount > 0 {
                showLoadingSpinner()
            }else{
                hideLoadingSpinner()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /**
     Shows a loading spinner on top of all subviews in this view controller.
     */
    fileprivate func showLoadingSpinner() {
        let spinnerWidth: CGFloat = 200
        
        spinnerView?.removeFromSuperview()
        spinner?.removeFromSuperview()
        
        spinnerView = UIView()
        spinnerView.translatesAutoresizingMaskIntoConstraints = false
        spinnerView.backgroundColor  = UIColor.black.withAlphaComponent(0.5)
        spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.color = UIColor.white
        spinner.startAnimating()
        self.view.addSubview(spinnerView)
        self.spinnerView?.addSubview(spinner)
        
        // constrainst for spinner
        NSLayoutConstraint(item: spinnerView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: spinnerView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: spinnerView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: spinner, attribute: .centerX, relatedBy: .equal, toItem: spinnerView, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: spinner, attribute: .centerY, relatedBy: .equal, toItem: spinnerView, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: spinner, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: spinnerWidth).isActive = true
        NSLayoutConstraint(item: spinner, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: spinnerWidth).isActive = true
    }
    
    /**
     Removes a previous instance of spinner if it exists.
     */
    fileprivate func hideLoadingSpinner() {
        spinner?.stopAnimating()
        spinnerView?.removeFromSuperview()
        spinner?.removeFromSuperview()
        spinnerView = nil
        spinner = nil
    }
    
    /// increase spinner count
    internal func addSpinner(){
        spinnerCount += 1
    }
    
    
    /// decrease spinner count and reset if is less than 0
    internal func removeSpinner(){
        spinnerCount -= 1
        if spinnerCount < 0{
            spinnerCount = 0
        }
    }
    
    /**
     Presents a pop up alert message with the specified `text`.
     - parameter message :  The message which is going to be presented.
     */
    func showAlert(_ message: String) {
        let alertController = UIAlertController(title: NSLocalizedString("Titulo", comment:"none"), message:
            message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("OK",comment:"none"), style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    /**
     Set up constraints for each object.
     */
    func setupConstrainst() {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

