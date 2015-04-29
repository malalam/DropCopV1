//
//  DealView.swift
//  DropCopR1
//
//  Created by Mo Alam on 4/28/15.
//  Copyright (c) 2015 Mo Alam. All rights reserved.
//

import UIKit
import SwiftHTTP

class DealView: UIViewController, UITableViewDataSource, UITableViewDelegate{

    func dropLoader(){
        //send request (assuming all other fields were entered correctly)
        var dI = DropItems(id: "",name: "", details: "", price: "", link: "", likes: "")
        var request =  HTTPTask()
        request.responseSerializer = JSONResponseSerializer()
        var urlStr:String = someVariables.IP_ADDR_PORT + "/deal"
        request.GET(urlStr, parameters: nil,
            success:{(response:HTTPResponse) in
                var regData:String = ""
                //parse response
                if let reg = response.responseObject as? NSArray{
                    // try to fill array
                    for items in reg{
                        if let arrData = items as? NSDictionary{
                            dI.name = arrData["name"] as String
                            dI.details = arrData["details"] as String
                            dI.price = arrData["price"] as String
                            dI.link = arrData["link"] as String
                            dI.likes = arrData["likes"] as String
                            dI.id = arrData["id"] as String
                            self.drop.append(dI)
                        }
                    }
                }
                self.droptable.reloadData()
                for stuff in self.drop{ println("DROP:\(stuff.name)")}
                return
                
            },
            failure:{(error:NSError,response:HTTPResponse?) in
                println("Deals error \(error)")
            }
        )
    }
    
    
    @IBOutlet weak var droptable: UITableView!
    
    @IBOutlet weak var dropBar: UINavigationBar!
    
    @IBOutlet weak var rightbut: UIBarButtonItem!
    
    var drop = [DropItems]()
    // Catch username
    var username: String?
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drop.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // configure cell
        let cell2 = tableView.dequeueReusableCellWithIdentifier("dropcellview", forIndexPath: indexPath) as dealViewCell
        
        // configure Cell with 'drop' array object
        var dropItem = drop[indexPath.row]
        
        //copCell elements
        cell2.namerLabel.text = dropItem.name
        cell2.pricerLabel.text = "$" + dropItem.price
        cell2.detailerLabel.text = dropItem.details
        cell2.likerLabel.text = dropItem.likes
        cell2.idLabel = dropItem.id
        return cell2
    }

    func refresherr(sender: AnyObject) {
        drop.removeAll(keepCapacity: false)
        dispatch_async(dispatch_get_main_queue(), {self.dropLoader()})
        println("Data has been refreshed")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dispatch_async(dispatch_get_main_queue(), {self.dropLoader()})
        self.droptable.reloadData()
        // Do any additional setup after loading the view.
        
        //configure right button bar item
        let refr = UIImage(named: "refresh")
        let backb = UIBarButtonItem(image: refr, style: UIBarButtonItemStyle.Bordered, target: self, action: "refresherr:")
        backb.tintColor = UIColor.lightTextColor()
        rightbut = backb
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        if(segue.identifier == "linkViewer"){
            var linkerView = segue.destinationViewController as LinkView
            // Pass the selected object to the new view controller.
            if let indexPath = self.droptable.indexPathForSelectedRow(){
                let selectedItem = drop[indexPath.row]
                linkerView.link = selectedItem.link
            }
        }
    }

}
