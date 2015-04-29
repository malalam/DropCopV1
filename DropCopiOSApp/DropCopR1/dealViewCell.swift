//
//  dealViewCell.swift
//  DropCopR1
//
//  Created by Mo Alam on 4/28/15.
//  Copyright (c) 2015 Mo Alam. All rights reserved.
//

import UIKit
import SwiftHTTP

class dealViewCell: UITableViewCell {
    
    var idLabel:String?
    
    @IBOutlet weak var namerLabel: UILabel!
    
    @IBOutlet weak var pricerLabel: UILabel!

    @IBOutlet weak var detailerLabel: UILabel!
    
    @IBOutlet weak var likerLabel: UILabel!
    
    @IBOutlet weak var cellLoader: UIView!
    
    
    @IBAction func likerButton(sender: AnyObject) {
        var request =  HTTPTask()
        request.responseSerializer = JSONResponseSerializer()
        var urlStr:String = someVariables.IP_ADDR_PORT + "/addLike"
        let eex = self.idLabel
        request.GET(urlStr, parameters: ["id":eex!],
            success:{(response:HTTPResponse) in
                var regData:String = ""
                //parse response
                if let reg = response.responseObject as? NSDictionary{
                    var liked = reg["addedLike"] as String
                    if( liked == "true"){
                        if let intdff = self.likerLabel.text?.toInt(){
                            var vare: Int = intdff + 1
                            self.likerLabel.text = String(vare)
                            self.cellLoader.reloadInputViews()
                        }
                    }
                }
            },
            failure:{(error:NSError,response:HTTPResponse?) in
                println("addedLike error \(error)")
            }
        )
    
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
