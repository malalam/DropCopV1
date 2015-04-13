//
//  RegistrationView.swift
//  DropCopR1
//
//  Created by Mo Alam on 4/4/15.
//  Copyright (c) 2015 Mo Alam. All rights reserved.
//

import UIKit

class RegistrationView: UIViewController {
    
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
