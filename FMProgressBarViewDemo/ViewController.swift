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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func valueChanged(sender: UISlider) {
        var currentValue = sender.value/sender.maximumValue
        
        pbar.progressPercent = CGFloat(currentValue)
    }

}

