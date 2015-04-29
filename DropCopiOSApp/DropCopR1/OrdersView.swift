//
//  OrdersView.swift
//  DropCopR1
//
//  Created by Mo Alam on 4/29/15.
//  Copyright (c) 2015 Mo Alam. All rights reserved.
//

import UIKit
import SwiftHTTP

struct OrderItem {
    var orderID: String
    var name: String
}

class OrdersView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var alertShowing:Bool = false
    
    var order = [OrderItem]()
    
    var user:String?
    var counter:Int?
    
    @IBOutlet weak var orderTabler: UITableView!
    
    func orderLoader(){
        //send request (assuming all other fields were entered correctly)
        var oI = OrderItem(orderID: "", name: "")
        var request =  HTTPTask()
        request.responseSerializer = JSONResponseSerializer()
        var urlStr:String = someVariables.IP_ADDR_PORT + "/getOrders"
        let username = user!
        var param:Dictionary<String,AnyObject> = ["username":username]
        request.GET(urlStr, parameters: param,
            success:{(response:HTTPResponse) in
                var regData:String = ""
                //parse response
                if let reg = response.responseObject as? NSArray{
                    println("RESPONSE \(reg)")
                    // try to fill array
                    for items in reg{
                        if let arrData = items as? NSDictionary{
                            oI.name = arrData["name"] as String
                            oI.orderID = arrData["oid"] as String
                            self.order.append(oI)
                        }
                    }
                }
                dispatch_async(dispatch_get_main_queue(), {self.orderTabler.reloadData()})
                for stuff in self.order{ println("DROP:\(stuff.name)")}
                return
                
            },
            failure:{(error:NSError,response:HTTPResponse?) in
                println("Deals error \(error)")
            }
        )
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.orderLoader()
        showAlertDispatch("Call 718-555-5555 to cancel an order", alertMessage: "Please note your order ID ")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return order.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell3 = tableView.dequeueReusableCellWithIdentifier("orderceller", forIndexPath: indexPath) as orderCell

        // Configure the cell...
        var currOrderItem = order[indexPath.row]
        
        //cell elements
        cell3.orderIDLabel.text = "Order ID: " + currOrderItem.orderID
        cell3.namerLabelo.text = currOrderItem.name
        
        return cell3
    }
    

    @IBAction func dismissBack(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Dispatches to main thread to show a UIAlert
    func showAlertDispatch(alertTitle:String, alertMessage:String){
        dispatch_async(dispatch_get_main_queue(), {
            if(!self.alertShowing){
                let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle:UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                self.alertShowing = true
            }
            else {
                self.alertShowing = false
            }
        })
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
