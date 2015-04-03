//
//  LoginView.swift
//  DropCopR1
//
//  Created by Mo Alam on 4/3/15.
//  Copyright (c) 2015 Mo Alam. All rights reserved.
//

import UIKit

class LoginView: UIViewController {
    // story board items
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func loginButton(sender: AnyObject) {
        //Verify login credentials
        
    }
    
    
    @IBOutlet weak var loginResponseLabel: UILabel!
    
    @IBAction func registerButton(sender: AnyObject) {
        //Segue to register page
        
    }
    
    //make sure keyboard disapears after we hit return
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    // resign keyboard when clicked blank space
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
