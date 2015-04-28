//
//  CopPage.swift
//  DropCopR1
//
//  Created by Mo Alam on 4/27/15.
//  Copyright (c) 2015 Mo Alam. All rights reserved.
//

import UIKit
import SwiftHTTP

class CopPage: UIViewController, UITextFieldDelegate {
    
    var item: CopItems?
    var user: String?
    var alertShowing:Bool = false
    // TEXTFIELDS
    @IBOutlet weak var sname: UITextField!
    @IBOutlet weak var saddress: UITextField!
    @IBOutlet weak var scity: UITextField!
    @IBOutlet weak var sstate: UITextField!
    @IBOutlet weak var szip: UITextField!
    @IBOutlet weak var sphone: UITextField!
    @IBOutlet weak var bname: UITextField!
    @IBOutlet weak var bccn: UITextField!
    @IBOutlet weak var bsn: UITextField!
    @IBOutlet weak var bexp: UITextField!
    
    
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBAction func confirmOrder(sender: AnyObject) {
        self.alertShowing = false
        let itemname = item?.name
        let itt:String = itemname! as String
        let usern:String = user!
        if( sname.text.isEmpty || saddress.text.isEmpty || scity.text.isEmpty || sstate.text.isEmpty || szip.text.isEmpty || sphone.text.isEmpty || bname.text.isEmpty || bccn.text.isEmpty || bsn.text.isEmpty || bexp.text.isEmpty ){
            self.showAlertDispatch("Empty Field", alertMessage: "Please fill all info")
            return
        }
        
        
        else{
            var error: NSError?
            var request = HTTPTask()
            request.requestSerializer = HTTPRequestSerializer()   // Serializes request as standard HTTP - default
            request.responseSerializer = JSONResponseSerializer() // Serializes response as JSON
            let params: Dictionary<String,AnyObject> = [ "username": usern, "item": itt, "sname": sname.text , "address": saddress.text , "city": scity.text, "state" : sstate.text, "zip": szip.text, "phone":sphone.text, "bname":bname.text, "cc": bccn.text, "sn": bsn.text, "exp":bexp.text ]
            request.GET((someVariables.IP_ADDR_PORT+"/confirm"), parameters: params, success: {(response: HTTPResponse) in
                println("response: \(response.responseObject!)")
                if response.responseObject != nil {
                    println("Request: \(request)")
                    // Parsing JSON response data - login: true indicates successful login
                    if let orderdict = response.responseObject as? NSDictionary{
                        
                        //find order data
                        var orderVerifyData = orderdict["order"] as String
                        println("Order Confirmation: \(orderVerifyData)")
                        
                        //Order Confirmed
                        if(orderVerifyData == "true"){
                            //SEGUE TO Cop Page
                            dispatch_async(dispatch_get_main_queue(), {
                                let alertController = UIAlertController(title: "Congratulations!", message: "Your order has been received!", preferredStyle:UIAlertControllerStyle.Alert)
                                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default){ (action) in
                                    self.performSegueWithIdentifier("exitToCop", sender: self)
                                    })
                            self.presentViewController(alertController, animated: true, completion: nil)
                            })
                        }
                            //Order Error
                        else{
                            self.showAlertDispatch("Order Unsuccessful!", alertMessage: "Try Again Later!")
                        }
                    }
                }
                }, // end of success parameter
                //Login response error
                failure: {(error:NSError, response: HTTPResponse?)in println("got an error: \(error)")
                    self.showAlertDispatch("Server Error", alertMessage:"Try Again later")
                }
            )// end of http get field
        }
    }

    @IBAction func cancelPage(sender: AnyObject) {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmButton.layer.backgroundColor = UIColor.darkGrayColor().CGColor
        confirmButton.layer.borderColor = UIColor.blackColor().CGColor
        confirmButton.layer.borderWidth = 0.3
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    // resign keyboard when clicked blank space
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    //make sure keyboard disapears after we hit return
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "exitToCop"){
            let dstVC = segue.destinationViewController as CopView
            dstVC.incrementer = item?.name
        }
    }


}
