//
//  CopView.swift
//  DropCopR1
//
//  Created by Mo Alam on 4/19/15.
//  Copyright (c) 2015 Mo Alam. All rights reserved.
//

import UIKit
import SwiftHTTP

class CopView: UITableViewController{
    
    //initialize items array
    var cop = [CopItems]()
    
    var currentUser: String?
    var incrementer: String?
    
    func copLoader(){
        //send request (assuming all other fields were entered correctly)
        var cI = CopItems(name: "", price: "", count: "", currCount: "", details: "", pic:"")
        
        
        var request =  HTTPTask()
        request.responseSerializer = JSONResponseSerializer()
        var urlStr:String = someVariables.IP_ADDR_PORT + "/buy"
        
        request.GET(urlStr, parameters: nil,
            success:{(response:HTTPResponse) in
                var regData:String = ""
                //parse response
                if let reg = response.responseObject as? NSArray{
                    
                    // try to fill array
                    for items in reg{
                        if let arrData = items as? NSDictionary{
                            cI.name = arrData["name"] as String
                            cI.count = arrData["count"] as String
                            cI.currCount = arrData["currCount"] as String
                            cI.details = arrData["details"] as String
                            cI.pic = arrData["pic"] as String
                            // ^ Download the pic link to different variable then download pic and store saved name as cI pic string
                            cI.price = arrData["price"] as String
                            self.cop.append(cI)
                        }
                    }
                }
                self.tableView.reloadData()
                for stuff in self.cop{ println("COP:\(stuff.name)")}
                return
                
            },
            failure:{(error:NSError,response:HTTPResponse?) in
                println("Buy error \(error)")
            }
        )
    }
    
    func shouldIncrement(){
        println("INCREMENTER: \(incrementer)")
        if (incrementer != nil){
        var x: Int = 0
        while (x < cop.count){
            if (cop[x].name == incrementer){
                let xx = cop[x].currCount.toInt()! + 1
                var xsss = String(xx)
                cop[x].currCount = xsss
            }
            x++
        }
        }
    }
    

    
    
    //Segue back to this page (Used on Registration page Cancel button)
    @IBAction func unwindToCopView(sender: UIStoryboardSegue){ }
    
    /*func imageDownloader(url:NSString){
        if let url = NSURL(string: currentItem!.pic){
          if let data = NSData(contentsOfURL: url){
                someImage.image = UIImage(data: data)
            }
        }
    }*/
    
    @IBOutlet weak var navbarr: UINavigationItem!
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        super.viewDidLoad()
        dispatch_async(dispatch_get_main_queue(), {self.copLoader()})
        println("This is cop:\(cop)")
        println("This is current user:\(currentUser)")
        
        //configure right button bar item
        let refr = UIImage(named: "refresh")
        let backb = UIBarButtonItem(image: refr, style: UIBarButtonItemStyle.Bordered, target: self, action: "refresheree:")
        backb.tintColor = UIColor.lightTextColor()
        navbarr.rightBarButtonItem = backb
        
    }
    
    override func viewWillAppear(animated: Bool) {
        //cop.removeAll(keepCapacity: false)
        println("VIEW WILL APPEAR")
        self.shouldIncrement()
        //dispatch_async(dispatch_get_main_queue(), {self.copLoader()})
    }
    
    override func viewDidDisappear(animated: Bool) {
        incrementer = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    //configure table length
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cop.count
    }

    //configure table cell as copCell class (copCell contains the data for UI elements)
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("copCell", forIndexPath: indexPath) as copCell
        
        // configure Cell with 'cop' array object
        var currentItem = cop[indexPath.row]
        
        //copCell elements
        //configure image and name
        cell.itemName.text = currentItem.name
        cell.itemPrice.text = "$" + currentItem.price
        // Download image and put it into image view
        println("DELAY")
        
        
        if let url = NSURL(string: currentItem.pic){
            println("loading element \(url)")
            if let data = NSData(contentsOfURL: url){
                println("Got image data")
                cell.itemImage.image = UIImage(data: data)
            }
        }
        
        return cell
    }
    
    @IBAction func refresheree(sender: AnyObject) {
        cop.removeAll(keepCapacity: false)
        dispatch_async(dispatch_get_main_queue(), {self.copLoader()})
        println("Data has been refreshed")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        if(segue.identifier == "itemviewer"){
            var itemViewer = segue.destinationViewController as itemView
            // Pass the selected object to the new view controller.
            if let indexPath = self.tableView.indexPathForSelectedRow(){
                let selectedItem = cop[indexPath.row]
                itemViewer.currentItem = selectedItem
                itemViewer.theuser = currentUser?.lowercaseString
            }
        }
    }



    /*

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
