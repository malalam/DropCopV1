//
//  CopView.swift
//  DropCopR1
//
//  Created by Mo Alam on 4/19/15.
//  Copyright (c) 2015 Mo Alam. All rights reserved.
//

import UIKit

class CopView: UITableViewController {
    
    //initialize items array
    var cop = [CopItems]()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load data + images
        
        // create new photo element
        var newPhoto = CopItems(name: "venom", price: "23", count: "200",currCount: "12", details: "Just a pic", pic: "download" )
        // insert it into array
        cop.append(newPhoto)
        var nee = CopItems(name: "carnage", price: "23", count: "2000", currCount: "12",details: "eji3",  pic: "download2")
        cop.append(nee)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    //configure table length
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cop.count
    }

    //configure table cell as copCell class (copCell contains the data for UI elements)
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("copCell", forIndexPath: indexPath) as copCell
        
        // configure Cell with 'cop' array object
        var currentItem = cop[indexPath.row]
        
        //copCell elements
        //configure image and name
        cell.itemName.text = currentItem.name.capitalizedString
        cell.itemPrice.text = "$" + currentItem.price
        cell.itemImage.image = UIImage(named: currentItem.pic)
        
        return cell
    }
   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        if(segue.identifier == "itemviewer"){
            var thirdScene = segue.destinationViewController as itemView
            // Pass the selected object to the new view controller.
            //thirdScene.currentPhoto = currentPhoto
        }
    }




    /*

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
