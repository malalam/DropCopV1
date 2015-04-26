//
//  testView.swift
//  DropCopR1
//
//  Created by Mo Alam on 4/18/15.
//  Copyright (c) 2015 Mo Alam. All rights reserved.
//

import UIKit
import SwiftHTTP
import Foundation

class testView: UIViewController {

    class func copButton(inout itemsee: [CopItems]){
        
        //send request (assuming all other fields were entered correctly)
        var cI = CopItems(name: "", price: "", count: "", currCount: "", details: "", pic: "")
        
            var request =  HTTPTask()
            request.responseSerializer = JSONResponseSerializer()
            var urlStr:String = someVariables.IP_ADDR_PORT + "/buy"
            
            request.GET(urlStr, parameters: nil,
                success:{(response:HTTPResponse) in
                    var regData:String = ""
                    //parse response
                    if let reg = response.responseObject as? NSArray{
                        println("This is the Array of Records \(reg)")
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
                                println("THIS IS THE MAIN CI SHIT \(cI.pic)")
                                itemsee.append(cI)
                            }
                        }
                    }
                    // /* Print test*/ for stuff in itemsee{ println("THIS IS FULL ITEMSEE LIST: \(stuff.name)") }
                },
                failure:{(error:NSError,response:HTTPResponse?) in
                    println("Buy error \(error)")
                }
            )
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
