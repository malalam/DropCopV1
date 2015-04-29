//
//  itemView.swift
//  DropCopR1
//
//  Created by Mo Alam on 4/26/15.
//  Copyright (c) 2015 Mo Alam. All rights reserved.
//

import UIKit

class itemView: UIViewController {
    
    var currentItem: CopItems?
    var theuser: String?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    
    @IBOutlet weak var countBar: UIProgressView!
    @IBOutlet weak var currCountLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var copButton: UIButton!
    
    @IBAction func cupBotton(sender: AnyObject) {
    }
    
    func adjustLabels(){
        nameLabel.text = currentItem?.name
        nameLabel.adjustsFontSizeToFitWidth = true
        
        detailsLabel.text = currentItem?.details
        detailsLabel.layer.backgroundColor = UIColor.lightTextColor().CGColor
    }
    
    func getImage(){
        let link = currentItem?.pic
        if let url = NSURL(string: link!){
            if let data = NSData(contentsOfURL: url){
               itemImage.image = UIImage(data: data)
            }
        }
    }
    @IBOutlet weak var leftEdgeCC: NSLayoutConstraint!
    
    func getBarPercentage(){
        var sizeRect = UIScreen.mainScreen().applicationFrame;
        var width = sizeRect.size.width;
        
        var numCount: Int? = currentItem?.currCount.toInt()
        var denCount: Int? = currentItem?.count.toInt()
        var thePerc:Float = Float(numCount!)/Float(denCount!)
        countLabel.text = currentItem?.count
        countLabel.textColor = UIColor.grayColor()
        
        if(numCount > denCount){
            countBar.setProgress(100.0, animated: true)
            countBar.progressTintColor = UIColor.greenColor()
            currCountLabel.text = currentItem?.currCount
            currCountLabel.textColor = UIColor.greenColor()
            let curt = currentItem?.count
            var min: String = "Minimum Reached: "
            countLabel.text = min + curt!
            countLabel.textColor = UIColor.greenColor()
            
        }
        else{
            countBar.progressTintColor = UIColor.orangeColor()
            countBar.setProgress(thePerc, animated: true)
            currCountLabel.text = currentItem?.currCount
            currCountLabel.textColor = UIColor.orangeColor()
            var edgeso:CGFloat = CGFloat(width)-40
            let cee: CGFloat = (20 + (edgeso * CGFloat(thePerc)))
            if ( thePerc > 0.8){
                leftEdgeCC.constant = cee - 25
            }
            else{
                leftEdgeCC.constant = cee
            }
        }
    }
    
    func buttonConf(){
        copButton.layer.backgroundColor = UIColor.lightTextColor().CGColor
        copButton.layer.borderColor = UIColor.blackColor().CGColor
        copButton.layer.borderWidth = 0.5
    }
    
    @IBAction func itemCancelButton(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("This is the user in the buy page:\(theuser)")
        adjustLabels()
        getImage()
        getBarPercentage()
        buttonConf()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "copPageViewer"){
            let buyView = segue.destinationViewController as CopPage
            buyView.item = currentItem
            buyView.user = theuser
        }
    }
    

}
