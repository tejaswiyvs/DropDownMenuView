//
//  ViewController.swift
//  DropDownMenu
//
//  Created by Tejaswi Yerukalapudi on 12/18/15.
//  Copyright © 2015 MCH. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var dropDownMenu: DropDownMenu!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dropDownMenu.menuItems = [ "Alaska", "Alabama", "Kentucky", "Florida", "Washington" ]
    }
}

