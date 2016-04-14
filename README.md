
# CDRFlowButton
You can try it by going in your terminal and running 'pod try CDRFlowButton'
Or add it to your project: pod 'CDRFlowButton'
<img src="https://github.com/cristi1900/CDRFlowButton/blob/master/CDRFlowButton_Presentation_edited.gif">


This is how you can use this button 

 ```
 
 class ViewController: UIViewController {

    var flowButton : CDRFlowButton!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.addCDRButton()
    }
    
    func addCDRButton () {
        if flowButton != nil {
            return
        }
        let buttonSize : CGFloat = 70.0
        
        let actionButton =  CDRFlowButton.init(type: .Custom)
        flowButton = actionButton
        flowButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(flowButton)
        
        flowButton.frame = CGRect(x: 10, y: 100, width: buttonSize, height: buttonSize)
        flowButton.addConstraint(NSLayoutConstraint(item: flowButton, attribute: .Height, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1.0, constant: CGFloat(buttonSize)))
        flowButton.addConstraint(NSLayoutConstraint(item: flowButton, attribute: .Width, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1.0, constant: CGFloat(buttonSize)))
        
        
        self.view.addConstraint(NSLayoutConstraint(item: flowButton, attribute: .Trailing, relatedBy: .Equal, toItem: self.view, attribute: .Trailing, multiplier: 1.0, constant: -15.0))
        self.view.addConstraint(NSLayoutConstraint(item: flowButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: -15.0))

        
        flowButton.layer.cornerRadius = buttonSize/2
       
        self.setupOptions()
        self.customizeFlowButton()
        
        self.view.layoutIfNeeded()
    }
    
    
    func setupOptions () {
        flowButton.resetButton()
        
        let button1 = CDRFlowActionItem.init(type: .Custom)
        let button2 = CDRFlowActionItem.init(type: .Custom)
        let button3 = CDRFlowActionItem.init(type: .Custom)
        
        button1.actionTitle = "Button 1 text";
        button2.actionTitle = "Button 2 text"
        button3.actionTitle = "Button 3 text"
        
        // for the button defaults to LabelPosition.PositionLeft
        button1.position = LabelPosition.PositionUp
        
        
        //adding the action buttons
        self.flowButton.addButtonWithImage(button1, icon : "icon_like" )
        self.flowButton.addButtonWithImage(button2, icon : "icon_close")
        self.flowButton.addButtonWithImage(button3, icon : "icon_history")
        
        
        
        // adding the action of the three buttons
        button1.addTarget(self, action: #selector(ViewController.button1Tapped), forControlEvents: .TouchUpInside);
        button2.addTarget(self, action: #selector(ViewController.button2Tapped), forControlEvents: .TouchUpInside);
        button3.addTarget(self, action: #selector(ViewController.button3Tapped), forControlEvents: .TouchUpInside);
    }
    
    func customizeFlowButton () {
  
        flowButton.backgroundColor =  UIColor(colorLiteralRed: 0.0, green: 0.478, blue: 1.0, alpha: 1.0)
        flowButton.labelBackgroundColor =  UIColor(colorLiteralRed: 0.0, green: 0.478, blue: 1.0, alpha: 1.0)
        flowButton.actionButtonBackgroundColor =  UIColor(colorLiteralRed: 0.0, green: 0.478, blue: 1.0, alpha: 1.0)
        
        flowButton.labelTextColor = UIColor.whiteColor()
        flowButton.labelBackgroundColor =  UIColor(colorLiteralRed: 0.0, green: 0.478, blue: 1.0, alpha: 1.0)
        flowButton.lineWidth = 30.0
        flowButton.lineColor = UIColor.whiteColor()
        flowButton.lineHeight = 2
        flowButton.updateAppearance()
    }
    
    // you can reset the button with animation and setup a new configuration of your actions
    func button1Tapped () {
        flowButton.resetButton()
        self.setupOptions()
    }
    
    // you can just close it
    func button2Tapped () {
        // perform action 
        self.flowButton.forceClose()
    }
    
    // or you cand just leave it open and perform your operation
    func button3Tapped () {
        // perform action
    }
    }
    
 ```

**If you wish to support me you can do it at my paypal address cristiandraica@gmail.com**
