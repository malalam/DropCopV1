//
//  mainmenu.swift
//  DropCopR1
//
//  Created by Mo Alam on 4/29/15.
//  Copyright (c) 2015 Mo Alam. All rights reserved.
//

import UIKit

class mainmenu: UIViewController {
    
    var crrUser: String?

    @IBOutlet weak var copHeight: NSLayoutConstraint!
    
    func fixHeights(){
        // fix heights of post buttons based on viewer
        var sizeRecta = UIScreen.mainScreen().applicationFrame;
        var screenheight: CGFloat?
        if( UIDeviceOrientation.Portrait.isPortrait) {
        screenheight = sizeRecta.size.height
        }
        else {
            screenheight = sizeRecta.size.width
        }
        
        copHeight.constant = (screenheight! / 2)

        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fixHeights()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func unwindToMainMenu(sender: UIStoryboardSegue){}
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // COP
        if(segue.identifier == "goCop"){
            let nextScene = segue.destinationViewController as UINavigationController
            let copScene = nextScene.viewControllers.first as CopView
            copScene.currentUser = crrUser
        }
        // DROP
        if(segue.identifier == "goDrop"){
            let dropScene = segue.destinationViewController as DealView
            dropScene.username = crrUser
        }
        
    }
    

}
