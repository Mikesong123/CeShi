//
//  SettingViewController.swift
//  csshi1
//
//  Created by 高 on 16/2/19.
//  Copyright © 2016年 高. All rights reserved.
//

import UIKit

class SettingViewController: UITableViewController {
    var tableview:UITableView!
    var celldata:NSMutableArray!
    override func viewDidLoad() {
        super.viewDidLoad()
//        var budel = NSBundle.mainBundle()
//        let  plistpath :String! = budel.pathForResource("video", ofType: "plist")
//        
//        self.navigationItem.leftBarButtonItem = self.editButtonItem()
//        let addBT = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "insertNew")
//        self.navigationItem.rightBarButtonItem = addBT
    }
    func insertNew(sender:AnyObject){
//        var item : NSDictionary = NSDictionary(objects:["http://c.hiphotos.baidu.com/video/pic/item/f703738da977391224eade15fb198618377ae2f2.jpg","新增数据"] , forKeys: ["video_img","video_title"])
//        celldata.insertObject(item, atIndex: 0)
//        let indexpath = NSIndexPath(forRow: 0, inSection: 0)
//        self.tableview.insertRowsAtIndexPaths([indexpath], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    //
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
//        return celldata.count
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40;
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellindent:String = "videoItem"
        let cell = tableview.dequeueReusableCellWithIdentifier(cellindent,forIndexPath: indexPath) as UITableViewCell
//        var row = indexPath.row
//        var rowDic :NSDictionary = celldata.objectAtIndex(row) as! NSDictionary
//        let url :String = rowDic.objectForKey("video_img") as! String
//        let dataimg :NSData = NSData(contentsOfURL: NSURL(string: url)!)!//
        cell.textLabel!.text = NSString(format: "%f" , indexPath.row) as String
        return cell
    }
}
