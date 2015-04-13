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

class LoginView: UIViewController, UITextFieldDelegate, NSURLConnectionDelegate {
    // story board items
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    // resign keyboard when clicked blank space
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    //make sure keyboard disapears after we hit return
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    //LOGIN BUTTON
    @IBAction func loginButton(sender: AnyObject) {
        //Verify login credentials
        
        // Text Field information
        let usr = usernameField.text
        let pss = passwordField.text

        if( usernameField.text.isEmpty || passwordField.text.isEmpty){
            loginResponseLabel.text = "Please don't leave any fields blank!"
            loginResponseLabel.textColor = UIColor.blueColor()
            usernameField.resignFirstResponder()
            passwordField.resignFirstResponder()
            return
        }
        else{
            // HTTP GET REQUEST FOR LOGIN
            var error: NSError?
            var request = HTTPTask()
            request.requestSerializer = HTTPRequestSerializer()
            
            request.GET("http://192.168.1.19:9090/login?"+"username="+usr+"&password="+pss, parameters: nil, success: {(response: HTTPResponse) in
                if response.responseObject != nil {
                    println("Request: \(request)")
                    // Printing just the string values
                    let str = NSString(data: response.responseObject as NSData, encoding: NSUTF8StringEncoding)
                    println("Got response : \(str)")
                    //if wanting to print substring
                    //var substr = str?.substringToIndex(6)
                    //println("response:substr: \(substr)")
                    println("Response Object: \(response.responseObject)")
                    println("Response text: \(response.text())")
                    // Parsing JSON data
                    // variable holding if login verified
                    var loginVerifyData: String
                    let data = response.responseObject as? NSData
                    var rsp: AnyObject? = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: &error)
                    if let logindict = rsp as? NSDictionary{
                        loginVerifyData = logindict["login"] as String
                        println("THIS IS LOGIN: \(loginVerifyData)")
                        //Login code 3 is successful credentials
                        if(loginVerifyData == "3"){
                            self.loginResponseLabel?.text = "Hello"
                            dispatch_async(dispatch_get_main_queue(), {
                                self.usernameField.resignFirstResponder()
                                self.passwordField.resignFirstResponder()
                            });
                        }
                        else{
                            // MUST DISPATCH TO MAIN THREAD IN ORDER TO EXECUTE - LOGIN FAILED
                            dispatch_async(dispatch_get_main_queue(), {
                                let alertController = UIAlertController(title: "Login Failed", message: "Try Again", preferredStyle:UIAlertControllerStyle.Alert)
                                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
                                self.presentViewController(alertController, animated: true, completion: nil)
                                });
                        }
                    }
                }
                },
                failure: {(error:NSError, response: HTTPResponse?)in println("got and error: \(error)")
                        // MUST DISPATCH TO MAIN THREAD IN ORDER TO EXECUTE - LOGIN FAILED
                        dispatch_async(dispatch_get_main_queue(), {
                            let alertController = UIAlertController(title: "Login Failed", message: "Try Again", preferredStyle:UIAlertControllerStyle.Alert)
                            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
                            self.presentViewController(alertController, animated: true, completion: nil)
                        });
                    
                } // end of failure statement
            )// end of http get field
        }
        
    }


    
        /*
        //username & password correct
        if usernameField?.text.lowercaseString == usr.lowercaseString && passwordField?.text == pw {
            loginResponseLabel.text = "Hello " + usr + " !"
            loginResponseLabel.textColor = UIColor.yellowColor()
            usernameField.resignFirstResponder()
            passwordField.resignFirstResponder()
        }
            // incorrect login
        else {
            loginResponseLabel.text = "Incorrect Login!"
            loginResponseLabel.textColor = UIColor.redColor()
            usernameField.resignFirstResponder()
            passwordField.resignFirstResponder()
        }
        */
    
    
    
    @IBOutlet var loginResponseLabel: UILabel!
    
    //REGISTER BUTTON - transitions to registration page
    //implemented using custom segue
    
    //Cancel button - transitions back to login page
    @IBAction func unwindToMainMenu(sender: UIStoryboardSegue)
    {
    }
    
    
    //++++++++++++++++++++++++++++++++++++++++++++++++++++
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

/*
things to do
- connect to data base and load up usernames and password
- interface usernames and passwords to check what the user enters
- if login verified, go to first page

*/