//
//  RegistrationView.swift
//  DropCopR1
//
//  Created by Mo Alam on 4/4/15.
//  Copyright (c) 2015 Mo Alam. All rights reserved.
//

import UIKit
import SwiftHTTP

class RegistrationView: UIViewController, UITextFieldDelegate {
    
    // LABELS
    @IBOutlet var registerTitleLabel: UIView!
    @IBOutlet var usernameLabel: UIView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel1: UILabel!
    @IBOutlet weak var passwordLabel2: UILabel!
    
    // TEXTFIELDS
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField1: UITextField!
    @IBOutlet weak var passwordField2: UITextField!
    
    // resign keyboard when clicked blank space
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    //make sure keyboard disapears after we hit return
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    // alert variable
    var alertShowing:Bool = false
    
    @IBAction func registerButton(sender: AnyObject) {
        //text field variables
        let usn = self.usernameField.text.lowercaseString
        let pss1 = self.passwordField1.text
        let pss2 = self.passwordField2.text
        let email = self.emailField.text
        
        self.view.endEditing(true) //resign text fields
        
        alertShowing = false //reset alert
        
        //no field should be blank
        if(usn.isEmpty || pss1.isEmpty || pss2.isEmpty || email.isEmpty){
            showAlertDispatch("Empty field", alertMessage: "Enter all data please")
            return
        }
        
        //password do not match
        if(pss1 != pss2){
            showAlertDispatch("Passwords do not match", alertMessage: "Please re-enter")
            return
        }
        
        //send request (assuming all other fields were entered correctly)
        else{
            var request =  HTTPTask()
            request.responseSerializer = JSONResponseSerializer()
            var urlStr:String = someVariables.IP_ADDR_PORT + "/register"
            var param:Dictionary<String,AnyObject> = ["username":usn, "password": pss1, "email": email]
            request.GET(urlStr, parameters: param,
                success:{(response:HTTPResponse) in
                    var regData:String = ""
                    //parse response
                    if let reg = response.responseObject as? NSDictionary{
                        //Registration update
                        regData = reg["registration"] as String
                        println("Registration response: \(regData)")
                    }
                    //check update
                    if( regData == "true" ){
                        self.showAlertDispatch("Congratulations!", alertMessage: "You can now login")
                        if !(self.alertShowing){
                            //segue to login page
                        }
                    }
                    else{
                        self.showAlertDispatch("Sorry... but", alertMessage: "Username or Email already registered.")
                    }
                },
                failure:{(error:NSError,response:HTTPResponse?) in
                    println("Registration error \(error)")
                    self.showAlertDispatch("Server Error", alertMessage: "Try registering later")
                })
            
            
        }
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
    
    
    
    /* =========================================== */
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
