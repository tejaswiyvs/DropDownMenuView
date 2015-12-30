//
//  ViewController.swift
//  DropDownMenu
//
//  Created by Tejaswi Yerukalapudi on 12/18/15.
//  Copyright © 2015 MCH. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var dropDownMenu: DropDownMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dropDownMenu = DropDownMenu.dropDownMenuWithWidth(200.0)
        self.dropDownMenu?.center = CGPointMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0)
        self.dropDownMenu?.menuItems = [ "Alaska", "Alabama", "Kentucky", "Florida", "Washington" ]
        self.dropDownMenu?.selectedIdx = 0
        
        self.view.addSubview(self.dropDownMenu!)
    }
    
//    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        if touches.count > 0 {
//            // Is it valid to just look at the first touch?
//            // TODO: Read docs on touchesEnded to write a better handler for touch outside dropDownMenu bounds
//            let touch = touches.first
//            let position = touch?.locationInView(self.view)
//            if position != nil && self.dropDownMenu != nil {
//                if !CGRectContainsPoint(self.dropDownMenu!.frame, position!) {
//                    self.dropDownMenu!.dismiss()
//                }
//            }
//        }
//        
//        super.touchesEnded(touches, withEvent: event)
//    }
}

