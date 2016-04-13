//
//  CDRFlowButton.swift
//  CDRFlowButton
//
//  Created by Cristi on 30/03/16.
//  Copyright © 2016 Cristi. All rights reserved.
//

import UIKit
//import JTHamburgerButton

class CDRFlowButton: JTHamburgerButton {
    
    private var buttonList : NSMutableArray!
    private var animationInDuration : Bool = false
    private var labelsList = NSMutableArray()
    private var isOpen : Bool = false
    var animationTime : CGFloat = 0.5
    var centerDistance : CGFloat = 90
    var actionButtonBackgroundColor : UIColor! {
        didSet {
            for button in buttonList {
                let buttonItem = button as! CDRFlowActionItem
                buttonItem.backgroundColor = actionButtonBackgroundColor
            }
        }
    }
    
    var labelBackgroundColor : UIColor! {
        didSet {
            for label in self.labelsList {
                let labelItem = label as! UILabel
                labelItem.backgroundColor = labelBackgroundColor
            }
        }
    }
    
    var labelTextColor : UIColor! {
        didSet {
            for label in self.labelsList {
                let labelItem = label as! UILabel
                labelItem.textColor = labelTextColor
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.loadComponent()
    }
    
    func loadComponent () {
        
        labelsList = NSMutableArray ()
        buttonList = NSMutableArray ()
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.addTarget(self, action: #selector(CDRFlowButton.toggleState), forControlEvents: .TouchUpInside)
        self.setCurrentModeWithAnimation(.Hamburger)
    }
    
    func addIcon(icon : String, forButton:AnyObject, imageRatio : CGFloat) {
        let workingButton = forButton as! UIButton
        let menuIcon = UIImageView.init(image: UIImage.init(named: icon))
        
        menuIcon.translatesAutoresizingMaskIntoConstraints = false
        
        workingButton.addSubview(menuIcon)
        
        workingButton.addConstraint(NSLayoutConstraint(item: menuIcon, attribute: .Height, relatedBy: .Equal, toItem: workingButton, attribute: .Height, multiplier: imageRatio, constant: 0.0))
        workingButton.addConstraint(NSLayoutConstraint(item: menuIcon, attribute: .Width, relatedBy: .Equal, toItem: workingButton, attribute: .Width, multiplier: imageRatio, constant: 0.0))
        workingButton.addConstraint(NSLayoutConstraint(item: menuIcon, attribute: .CenterX, relatedBy: .Equal, toItem: workingButton, attribute: .CenterX, multiplier: 1.0, constant: 0.0))
        workingButton.addConstraint(NSLayoutConstraint(item: menuIcon, attribute: .CenterY, relatedBy: .Equal, toItem: workingButton, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        workingButton.superview?.layoutIfNeeded()
    }
    
    //hides everything and reset all lists
    func resetButton () {
        self.forceClose()
        self.loadComponent()
    }
    
    func addButtonWithImage(button : CDRFlowActionItem, icon : String?) {
        if buttonList == nil {
            loadComponent()
        }
        buttonList.addObject(button)
        self.superview?.insertSubview(button, belowSubview: self)
        
        button.frame = CGRectMake(0, 0, 50, 50)
        button.center = self.center
        self.addLabelForButton(button)
        if icon != nil {
            self.addIcon(icon!, forButton: button , imageRatio : 0.8)
        }
        button.layer.cornerRadius = CGRectGetHeight(button.frame)/2
        if actionButtonBackgroundColor != nil {
            button.backgroundColor = actionButtonBackgroundColor
        }
        button.center = self.center
        self.transButton(button, showAnimation: false)
    }
    
    func addLabelForButton ( button : CDRFlowActionItem) {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.alpha = 0.0
        
        if labelBackgroundColor != nil {
            label.backgroundColor = labelBackgroundColor
        }
        
        if labelTextColor != nil {
            label.textColor = labelTextColor
        }
        
        self.superview?.addSubview(label)
        switch button.position {
        case LabelPosition.PositionLeft :
            self.superview?.addConstraint(NSLayoutConstraint(item: label, attribute: .Trailing, relatedBy: .Equal, toItem: button, attribute: .Leading, multiplier: 1.0, constant: -10))
            self.superview?.addConstraint(NSLayoutConstraint(item: label, attribute: .CenterY, relatedBy: .Equal, toItem: button, attribute: .CenterY, multiplier: 1.0, constant: -5))
            break;
        case LabelPosition.PositionUp :
            self.superview?.addConstraint(NSLayoutConstraint(item: label, attribute: .Trailing, relatedBy: .Equal, toItem: button, attribute: .Trailing, multiplier: 1.0, constant: -10))
            self.superview?.addConstraint(NSLayoutConstraint(item: label, attribute: .CenterY, relatedBy: .Equal, toItem: button, attribute: .Top, multiplier: 1.0, constant: -15))
            break;
        }
        label.addConstraint(NSLayoutConstraint(item: label, attribute: .Height, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1.0, constant: 25));
        
        label.text = ("  \(button.actionTitle)  ")
        
        label.layer.cornerRadius = 10.0
        label.clipsToBounds = true
        label.textColor = UIColor.whiteColor()
        
        self.labelsList.addObject(label)
        
    }
    
    func forceClose () {
        self.setCurrentModeWithAnimation(.Hamburger, duration: CGFloat(self.animationTime * (1.0/3.0)))
        self.closeAnimation()
    }
    
    func toggleState () {
        if animationInDuration == true {
            return
        }
        if isOpen == true {
            self.closeAnimation()
            self.setCurrentModeWithAnimation(.Hamburger, duration: CGFloat(self.animationTime * (1.0/3.0)))
        } else {
            self.openAnimation()
            self.setCurrentModeWithAnimation(.Cross, duration: CGFloat(self.animationTime * (1.0/3.0)))
        }
        self.isOpen = !self.isOpen
    }
    
    func closeAnimation () {
        if (buttonList == nil) {
            return
        }
        self.animationInDuration = true
        self.isOpen = false
        self.animateLabels(false)
        UIView.animateWithDuration(Double(animationTime), delay: 0.2, usingSpringWithDamping: animationTime + 0.1, initialSpringVelocity: 0.0, options: .BeginFromCurrentState, animations: {
            self.resetButtonPositions()
            self.rotateBack()
        }) { (complete) in
            self.animationInDuration = false
            self.isOpen = false
        }
    }
    
    //This will be called from the "openAnimation" animation block,
    //and everything in here will be animated with the block specified animation
    func alingButtons () {
        if self.buttonList.count == 3 {
            let x = self.center.x
            let y = self.center.y
            for button in buttonList {
                self.transButton(button as! CDRFlowActionItem, showAnimation: true)
                let button1 = button as! CDRFlowActionItem
                switch buttonList.indexOfObject(button) {
                case 0:
                    button1.center = CGPointMake(x, y-centerDistance)
                    break
                    
                case 1:
                    button1.center = CGPointMake(x-centerDistance+25, y-centerDistance+25)
                    
                    break
                    
                case 2:
                    button1.center = CGPointMake(x-centerDistance, y)
                    
                    break
                default:
                    button1.center = self.center
                }
            }
        } else {
            print("Implement handling for more butons");
        }
    }
    
    //This will be called from the "closeAnimation" animation block,
    //and everything in here will be animated with the block specified animation
    func resetButtonPositions () {
        for button in buttonList {
            let button1 = button as! CDRFlowActionItem
            button1.center = self.center
            self.transButton(button as! CDRFlowActionItem, showAnimation: false)
        }
    }
    
    
    
    func openAnimation () {
        self.animationInDuration = true
        
        UIView.animateWithDuration(Double(animationTime), delay: 0.0, usingSpringWithDamping: animationTime, initialSpringVelocity: 0.0, options: .BeginFromCurrentState, animations: {
            self.alingButtons()
            self.rotate();
        }) { (complete) in
            self.animationInDuration = false
            self.isOpen = true
            self.animateLabels(true)
        }
    }
    
    func rotate () {
        let rotation = CGFloat(-90.0/180*M_PI);
        self.transform = CGAffineTransformMakeRotation(rotation)
    }
    
    func transButton(button:CDRFlowActionItem , showAnimation:Bool) {
        if showAnimation == true {
            button.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0)
        } else {
            button.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1)
        }
    }
    
    func rotateBack () {
        self.transform = CGAffineTransformIdentity
    }
    
    func animateLabels (animated : Bool) {
        
        if (animated == true) {
            UIView.animateWithDuration(0.1) {
                for label in self.labelsList {
                    let labelItem = label as! UILabel
                    if self.isOpen == true {
                        labelItem.alpha = 1.0
                    } else {
                        labelItem.alpha = 0.0
                    }
                }
            }
        } else {
            for label in self.labelsList {
                let labelItem = label as! UILabel
                if self.isOpen == true {
                    labelItem.alpha = 1.0
                } else {
                    labelItem.alpha = 0.0
                }
            }
        }
    }
}
