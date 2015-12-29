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
    static let defaultHeight: CGFloat = 30.0
    static let dropDownHeight: CGFloat = 200.0
    static let defaultValue = "Select"
    static let dropDownCheckMarkDimension: CGFloat = 24.0
    static let padding: CGFloat = 3.0
    
    enum SelectionMode {
        case Single, Multi
    }
    
    var menuItems: [String]? {
        didSet {
            self.tableView?.reloadData()
        }
    }
    
    var defaultValue: String? {
        didSet {
            self.valueLbl?.text = defaultValue
        }
    }
    
    var tableView: UITableView?
    var valueLbl: UILabel?
    var selectedIndexes: [Int] = []
    var tapGestureRecognizer: UITapGestureRecognizer?
    var showing: Bool = false
    var selectionMode: SelectionMode = .Single
    
    static func dropDownMenuWithWidth(width: CGFloat) -> DropDownMenu {
        return DropDownMenu(frame: CGRectMake(0.0, 0.0, width, DropDownMenu.defaultHeight))
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
        self.addValueLabel()
        self.userInteractionEnabled = true
    }
    
    func dropDownTapped(sender: UIGestureRecognizer) {
        self.animateAddTableView()
    }
    
    func addValueLabel() {
        let padding: CGFloat = DropDownMenu.padding
        self.valueLbl = UILabel(frame: CGRectMake(padding, 0.0, self.bounds.width - DropDownMenu.dropDownCheckMarkDimension - (3 * padding), DropDownMenu.defaultHeight))
        self.valueLbl?.text = self.defaultValueOrConstant()
        self.valueLbl?.textColor = UIColor.blackColor()
        self.addSubview(self.valueLbl!)
    }
    
    func animateAddTableView() {
        UIView.animateWithDuration(0.3) { [unowned self]() -> Void in

            self.showing = true
            
            let boundsToAnimateTo = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.width, self.bounds.height + DropDownMenu.dropDownHeight)
            
            self.tableView = UITableView(frame: self.bounds)
            self.tableView?.delegate = self
            self.tableView?.dataSource = self
            self.addSubview(self.tableView!)
            self.tableView?.reloadData()

            
            self.tableView?.frame = boundsToAnimateTo
            self.bounds = boundsToAnimateTo
        }
    }
    
    func animateRemoveTableView() {
        UIView.animateWithDuration(0.3,
            animations: { () -> Void in
                self.tableView?.alpha = 0.0
                let boundsToAnimateTo = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.width, self.bounds.height - DropDownMenu.dropDownHeight)
                self.bounds = boundsToAnimateTo
                self.tableView?.frame = boundsToAnimateTo
            },
            completion: { (completed) -> Void in
                self.tableView?.removeFromSuperview()
                self.showing = false
            }
        )
    }
    
    func addDropDownCheckBox() {
        let dropDownCheckMarkDimension = DropDownMenu.dropDownCheckMarkDimension
        let padding = DropDownMenu.padding
        
        let x = self.bounds.size.width - dropDownCheckMarkDimension - padding
        let y = (self.bounds.size.height - dropDownCheckMarkDimension) / 2.0
        
        let imageView = UIImageView(frame: CGRectMake(x, y, dropDownCheckMarkDimension, dropDownCheckMarkDimension))
        imageView.image = UIImage(named: "drop-down")
        
        self.tapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("dropDownTapped:"))
        self.tapGestureRecognizer?.numberOfTapsRequired = 1
        self.tapGestureRecognizer?.numberOfTouchesRequired = 1
        
        imageView.addGestureRecognizer(self.tapGestureRecognizer!)
        imageView.userInteractionEnabled = true
        
        self.addSubview(imageView)
    }
    
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
        if let idx = self.selectedIndexes.indexOf(indexPath.row) {
            self.selectedIndexes.removeAtIndex(idx)
            if self.selectionMode == .Single {
                self.valueLbl?.text = self.defaultValueOrConstant()
            }
        }
        else {
            self.selectedIndexes.append(indexPath.row)
            if self.selectionMode == .Single {
                self.valueLbl?.text = self.menuItems![indexPath.row]
            }
            self.dismiss()
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
    }
    
    func defaultValueOrConstant() -> String {
        return self.defaultValue != nil ? self.defaultValue! : DropDownMenu.defaultValue
    }
    
    func complete() -> Bool {
        return self.selectedIndexes.count > 0
    }
    
    func dismiss() {
        if self.showing {
            self.animateRemoveTableView()
        }
    }
}