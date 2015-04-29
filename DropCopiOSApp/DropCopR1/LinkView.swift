//
//  LinkView.swift
//  DropCopR1
//
//  Created by Mo Alam on 4/29/15.
//  Copyright (c) 2015 Mo Alam. All rights reserved.
//

import UIKit

class LinkView: UIViewController {

    var link: String?
    
    @IBOutlet weak var linkWeb: UIWebView!
    
    func loadAddressURL(){
        let requesturl = NSURL(string: link!)
        if (requesturl != nil){
            let request = NSURLRequest(URL: requesturl!)
            linkWeb.loadRequest(request)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAddressURL()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBut(sender: AnyObject) {
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

}
