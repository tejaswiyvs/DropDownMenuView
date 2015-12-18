//
//  DropDownMenu.swift
//  DropDownMenu
//
//  Created by Tejaswi Yerukalapudi on 12/18/15.
//  Copyright © 2015 MCH. All rights reserved.
//

import Foundation
import UIKit

class DropDownMenu : UIView, UITableViewDelegate, UITableViewDataSource {
    
    static let reuseId = "DropDownMenuReuseId"
    static let defaultHeight = 30.0
    static let dropDownHeight: CGFloat = 200.0
    
    var menuItems: [String]? {
        didSet {
            self.tableView?.reloadData()
        }
    }
    
    var defaultValue: String?
    
    var tableView: UITableView?
    var selectedItem: String?
    var tapGestureRecognizer: UITapGestureRecognizer?
    
    static func dropDownMenuWithWidth(width: CGFloat) -> DropDownMenu {
        return DropDownMenu(frame: CGRectMake(0.0, 0.0, width, DropDownMenu.dropDownHeight))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    func commonInit() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.addDropDownCheckBox()
    }
    
    func dropDownTapped(sender: UIGestureRecognizer) {
        self.animateAddTableView()
    }
    
    func animateAddTableView() {
        UIView.animateWithDuration(0.5) { () -> Void in
            
            self.tableView = UITableView(frame: self.bounds)
            self.tableView?.delegate = self
            self.tableView?.dataSource = self
            self.addSubview(self.tableView!)
            self.tableView?.reloadData()

            
            self.bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.width, self.bounds.height + DropDownMenu.dropDownHeight)
        }
    }
    
    func addDropDownCheckBox() {
        let dropDownCheckMarkDimension: CGFloat = 24.0
        let padding: CGFloat = 3.0
        let x = self.bounds.size.width - dropDownCheckMarkDimension - padding
        let y = (self.bounds.size.height - dropDownCheckMarkDimension - padding) / 2.0
        
        let imageView = UIImageView(frame: CGRectMake(x, y, dropDownCheckMarkDimension, dropDownCheckMarkDimension))
        imageView.image = UIImage(named: "drop-down")
        
        self.tapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("dropDownTapped:"))
        self.tapGestureRecognizer?.numberOfTapsRequired = 1
        self.tapGestureRecognizer?.numberOfTouchesRequired = 1
        
        imageView.addGestureRecognizer(self.tapGestureRecognizer!)
        imageView.userInteractionEnabled = true

        self.addSubview(imageView)
    }
    
//    func animateRemoveTableView() {
//        UIView.animateWithDuration(1.0, animations: { () -> Void in
//            self.tableView?.alpha = 0.0
//            self.bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.width, self.bounds.height - DropDownMenu.dropDownHeight)
//            }) { (completed) -> Void in
//            }
//        }
//    }
    
    // MARK :- TableView
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.menuItems != nil) ? self.menuItems!.count : 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(DropDownMenu.reuseId)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: DropDownMenu.reuseId)
        }
        
        let item = menuItems![indexPath.row]
        cell?.textLabel?.text = item
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let item = menuItems![indexPath.row]
        self.selectedItem = item
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func complete() -> Bool {
        return self.selectedItem != nil
    }
}