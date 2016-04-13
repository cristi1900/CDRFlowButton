//
//  CDRFlowActionItem.swift
//  Restaurant Intim Menu
//
//  Created by Cristi on 10/04/16.
//  Copyright © 2016 RaduPop. All rights reserved.
//

import UIKit

enum LabelPosition: Int {
   case PositionLeft = 0, PositionUp
    
};

class CDRFlowActionItem: UIButton {

    var actionTitle : String!
    var position : LabelPosition = LabelPosition.PositionLeft
    
    // increases the touch zone with buttonTreshold
    let buttonTreshold : CGFloat = 10.0


    
    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        
        if self.between(point.x, left: (-1)*(buttonTreshold), right: (self.frame.size.width + buttonTreshold))
        && self.between(point.y, left: (-1)*(buttonTreshold), right: (self.frame.size.height + buttonTreshold)){
            return true;
        }
        return false;
    }
    
    func between(value : CGFloat, left : CGFloat, right : CGFloat) -> Bool {
        if (value >= left && value <= right) {
            return true;
        }
        return false;
    }
}




//contentEdgeInsets

