//
//  ViewController.swift
//  FMProgressBarViewDemo
//
//  Created by felipe munoz on 7/8/15.
//  Copyright (c) 2015 felipe munoz. All rights reserved.
//

import UIKit
import FMProgressBarView
class ViewController: UIViewController {

    @IBOutlet weak var mySlider: UISlider!
    @IBOutlet weak var pbar: FMProgressBarView!
    @IBOutlet weak var pbar2: FMProgressBarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //you can set the parameters on Interface Builder or programmatically
        /*
        self.pbar.title = "Custom Text.."
        self.pbar.titleFont = UIFont(name:"Helvetica", size: 27.0)!
        self.pbar.titleCompletedColor = UIColor.blackColor()
        self.pbar.titleLoadingColor = UIColor.whiteColor()
        
        self.pbar.backgroundCompletedColor = UIColor.greenColor()
        self.pbar.backgroundLoadingColor = UIColor.redColor()
        
        self.pbar.borderWidth = 1.0
        self.pbar.borderColor = UIColor.blueColor()
        */
        self.pbar.titleFont = UIFont(name:"Helvetica", size: 27.0)!
        self.pbar2.titleFont = UIFont(name:"Helvetica", size: 27.0)!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func valueChanged(sender: UISlider) {
        var currentValue = sender.value/sender.maximumValue
        
        pbar.progressPercent = CGFloat(currentValue)
        pbar2.progressPercent = CGFloat(currentValue)
    }

}

