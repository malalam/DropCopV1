//
//  LoginView.swift
//  DropCopR1
//
//  Created by Mo Alam on 4/3/15.
//  Copyright (c) 2015 Mo Alam. All rights reserved.
//

import UIKit
import SwiftHTTP
import Foundation

struct someVariables{
    static var IP_ADDR_PORT:String = "http://192.168.56.100:9090"
}

class LoginView: UIViewController, UITextFieldDelegate, NSURLConnectionDelegate {
    // story board items
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet var loginResponseLabel: UILabel!
    
    //is UIAlert already showing
    var alertShowing: Bool = false
    
    // resign keyboard when clicked blank space
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    //make sure keyboard disapears after we hit return
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    //LOGIN BUTTON - verify login credentials
    @IBAction func loginButton(sender: AnyObject) {
        //alert has been dismissed
        self.alertShowing = false
        
        self.view.endEditing(true) //end editing
        
        // Text Field information
        let usr = usernameField.text.lowercaseString
        let pss = passwordField.text
        
        // User left a field empty
        if( usernameField.text.isEmpty || passwordField.text.isEmpty){
            showAlertDispatch("Empty Field", alertMessage: "Don't leave any fields blank!")
            return
        }
        // Send GET request to server to verify login credentials
        else{
            var error: NSError?
            var request = HTTPTask()
            request.requestSerializer = HTTPRequestSerializer()   // Serializes request as standard HTTP - default
            request.responseSerializer = JSONResponseSerializer() // Serializes response as JSON
            let params: Dictionary<String,AnyObject> = ["username": usr, "password": pss]
            request.GET((someVariables.IP_ADDR_PORT+"/login"), parameters: params, success: {(response: HTTPResponse) in
                println("response: \(response.responseObject!)")
                if response.responseObject != nil {
                    println("Request: \(request)")
                    // Parsing JSON response data - login: true indicates successful login
                    if let logindict = response.responseObject as? NSDictionary{
                        
                        //find login data
                        var loginVerifyData = logindict["login"] as String
                        println("THIS IS LOGIN: \(loginVerifyData)")
                        
                        //Login pass
                        if(loginVerifyData == "true"){
                            //SEGUE TO MAIN VIEW
                            //self.showAlertDispatch("HELLO!", alertMessage: "Welcome to DropCop")
                            self.performSegueWithIdentifier("mainView", sender: self)
                        }
                        //Password fail
                        else if(loginVerifyData == "pfalse"){
                            self.showAlertDispatch("Password failed", alertMessage: "Try Again")
                        }
                        //Login credentials did not match
                        else{
                            self.showAlertDispatch("Login Unsuccessful", alertMessage: "User not found. Register!")
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
    
    //Segue back to this page (Used on Registration page Cancel button)
    @IBAction func unwindToMainMenu(sender: UIStoryboardSegue){ }
    
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
    
   
    /*++++++++++++++++++++++++++++++++++++++++++++++++++++*/
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        if(segue.identifier == "mainView"){
            let nextScene = segue.destinationViewController as UINavigationController
            let actualScene = nextScene.viewControllers.first as CopView
            actualScene.currentUser = self.usernameField?.text
        }
    }
    

}
