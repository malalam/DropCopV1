//
//  itemView.swift
//  DropCopR1
//
//  Created by Mo Alam on 4/26/15.
//  Copyright (c) 2015 Mo Alam. All rights reserved.
//

import UIKit

class itemView: UIViewController {
    
    var copee = [CopItems]()
    
    @IBAction func itemCancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func button2(sender: AnyObject) {
        testView.copButton(&copee)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        testView.copButton(&copee)
        for stuffee in copee {
            println("coffee stufee: \(stuffee.details)")
        }
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
