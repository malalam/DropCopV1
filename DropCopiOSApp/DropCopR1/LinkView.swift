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
        if(link != nil){
            if(link?.hasPrefix("http://") == true){
                let requesturl = NSURL(string: link!)
                let request = NSURLRequest(URL: requesturl!)
                self.linkWeb.loadRequest(request)
            }
            else if (link?.hasPrefix("www") == true ){
                let link2  = "http://" + link!
                let requesturl = NSURL(string: link2)
                let request = NSURLRequest(URL: requesturl!)
                self.linkWeb.loadRequest(request)
            }
            else{
                let link3  = "http://www" + link!
                let requesturl = NSURL(string: link3)
                let request = NSURLRequest(URL: requesturl!)
                self.linkWeb.loadRequest(request)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dispatch_async(dispatch_get_main_queue(), { self.loadAddressURL() })
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
