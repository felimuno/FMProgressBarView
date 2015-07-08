//
//  FMProgressBarView.swift
//  FMProgressBarViewDemo
//
//  Created by felipe munoz on 7/8/15.
//  Copyright (c) 2015 felipe munoz. All rights reserved.
//

import UIKit

@IBDesignable public class FMProgressBarView: UIView {
    
    // Our custom view from the XIB file
    var view: UIView!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    var loadingImage:UIImage!
    var completedImage:UIImage!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clearColor() {
        didSet {
            layer.borderColor = borderColor.CGColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true;
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
            
        }
    }
    @IBInspectable var title: String = "" {
        didSet {
            layer.borderWidth = 1
            self.updateImages()
            
        }
    }
    @IBInspectable var titleLoadingColor: UIColor = UIColor.blackColor() {
        didSet {
            self.updateImages()
            
        }
    }
    @IBInspectable var titleCompletedColor: UIColor = UIColor.blueColor() {
        didSet {
            self.updateImages()
            
        }
    }
    @IBInspectable var backgroundLoadingColor: UIColor = UIColor.redColor() {
        didSet {
            self.updateImages()
            
        }
    }
    @IBInspectable var backgroundCompletedColor: UIColor = UIColor.yellowColor() {
        didSet {
            self.updateImages()
            
        }
    }
    
    
    @IBInspectable public var progressPercent: CGFloat = 0 {
        didSet {
            if(progressPercent >= 0 && progressPercent <= 1.0){
                self.updateBar()
            }
        }
    }
    
    func xibSetup() {
        view = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        // Make the view stretch with containing view
        view.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "FMProgressBarView", bundle: bundle)
        
        // Assumes UIView is top level and only object in CustomView.xib file
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
    func updateImages(){
        self.loadingImage = self.getBarImage(self.backgroundLoadingColor,textColor:self.titleLoadingColor)
        self.completedImage = self.getBarImage(self.backgroundCompletedColor,textColor:self.titleCompletedColor)
        self.updateBar()
        
    }
    func updateBar(){
        if(self.loadingImage == nil || self.completedImage == nil){
            self.updateImages()
        }
        self.backgroundImage.image = self.updateViewWithPercent(progressPercent,text: title as NSString)
        self.backgroundImage.clipsToBounds = true
    }
    
    func updateViewWithPercent(percent:CGFloat, text:NSString) -> UIImage{
        return getmixedimages(percent, im1:self.completedImage ,im2:self.loadingImage)
    }
    func getmixedimages(percent:CGFloat,im1:UIImage,im2:UIImage)->UIImage{
        UIGraphicsBeginImageContext(im1.size)
        im1.drawInRect(CGRectMake(0,0,im1.size.width,im1.size.height));
        if(percent > 0){
            var newRect = CGRectMake(0,0,ceil(im1.size.width*percent),im1.size.height)
            var croppedImage:CGImageRef = CGImageCreateWithImageInRect (im2.CGImage, newRect)
            UIImage(CGImage:croppedImage)!.drawInRect(CGRectMake(0,0,ceil(im1.size.width*percent),im1.size.height));
        }
        var newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func getBarImage(color:UIColor, textColor:UIColor)->UIImage{
        
        // Setup the font specific variables
        let aFont = UIFont.systemFontOfSize(25.0)
        var loadingText:NSString = self.title as NSString
        var style:NSMutableParagraphStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        style.alignment = NSTextAlignment.Center;
        
        let attr:CFDictionaryRef = [NSFontAttributeName:aFont,NSForegroundColorAttributeName:textColor,NSParagraphStyleAttributeName:style]
        var textSize = loadingText.sizeWithAttributes(attr as [NSObject : AnyObject])
        
        //draw text in view
        let viewSize = self.view.frame.size
        UIGraphicsBeginImageContext(viewSize);
        
        let context = UIGraphicsGetCurrentContext();
        
        // set the fill color
        color.setFill()
        
        let rect = CGRectMake(0, 0, viewSize.width, viewSize.height)
        
        CGContextAddRect(context, rect)
        CGContextDrawPath(context,kCGPathFill)
        
        loadingText.drawInRect(CGRectMake(rect.origin.x,
            rect.origin.y + (rect.size.height - textSize.height)/2.0,
            rect.size.width,
            textSize.height), withAttributes: attr as [NSObject : AnyObject])
        var coloredImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return coloredImg;
    }
    
}