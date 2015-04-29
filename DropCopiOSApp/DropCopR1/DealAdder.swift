//
//  DealAdder.swift
//  DropCopR1
//
//  Created by Mo Alam on 4/29/15.
//  Copyright (c) 2015 Mo Alam. All rights reserved.
//

import UIKit
import SwiftHTTP

class DealAdder: UIViewController, UITextFieldDelegate {
    
    var alertShowing:Bool = false
    
    var user: String?

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var details: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var link: UITextField!
    
    
    
    @IBAction func submitButton(sender: AnyObject) {
        alertShowing = false
        if ( name.text.isEmpty || details.text.isEmpty || price.text.isEmpty || link.text.isEmpty){
            showAlertDispatch("Empty Field", alertMessage: "Please don't leave any field blank")
        }
        else{
            var request =  HTTPTask()
            request.responseSerializer = JSONResponseSerializer()
            var urlStr:String = someVariables.IP_ADDR_PORT + "/addDeal"
            var parame: Dictionary<String,AnyObject> = [ "username" : user!, "name" : name.text, "details" : details.text, "price" : price.text , "link": link.text]
            request.GET(urlStr, parameters: parame,
                success:{(response:HTTPResponse) in
                    var regData:String = ""
                    //parse response
                    if let reg = response.responseObject as? NSDictionary{
                        //Registration update
                        regData = reg["dealAdded"] as String
                        println("Has deal been added? : \(regData)")
                    }
                    //check update
                    if( regData == "true" ){
                        //self.showAlertDispatch("Congratulations!", alertMessage: "You can now login")
                        let alertController = UIAlertController(title: "Congratulations!", message: "Your deal has been added!", preferredStyle:UIAlertControllerStyle.Alert)
                        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default){ (action) in
                            self.dismissViewControllerAnimated(true, completion: nil)
                            })
                        self.presentViewController(alertController, animated: true, completion: nil)
                        
                        
                    }
                    else{
                        self.showAlertDispatch("Encountered an error.", alertMessage: "Try again later.")
                    }
                },
                failure:{(error:NSError,response:HTTPResponse?) in
                    println("Deal Adder error \(error)")
                    self.showAlertDispatch("Server Error", alertMessage: "Try again later")
            })
            
            
            
        }
        
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cancelAdd(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
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

}
