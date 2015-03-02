//
//  TodayViewController.swift
//  Shorten
//
//  Created by Finn Gaida on 24.02.15.
//  Copyright (c) 2015 Finn Gaida. All rights reserved.
//

import UIKit
import Foundation
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var shortenButton: UIButton!
    
    @IBAction func shorten(sender: AnyObject) {
        
        let accessToken = "your-access-token"
        let baseURL:String! = "https://api-ssl.bitly.com/v3/shorten?access_token=\(accessToken)"
        let fga:String! = UIPasteboard.generalPasteboard().string?.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        let urlStr:String! = "\(baseURL)&longUrl=\(fga)"
        let url = NSURL(string: urlStr)!
        
        let webData = NSData(contentsOfURL: url, options: NSDataReadingOptions.DataReadingMappedIfSafe, error: nil)
        var dict: NSDictionary = NSJSONSerialization.JSONObjectWithData(webData!, options: NSJSONReadingOptions.MutableLeaves, error: nil) as! NSDictionary
        
        let shortURL:AnyObject? = dict["data"]!["url"]
        urlLabel.text = "\(shortURL!) copied to clipboard"
        
        UIPasteboard.generalPasteboard().string = shortURL as? String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        shortenButton.layer.borderWidth = 2.0
        shortenButton.layer.borderColor = UIColor.whiteColor().CGColor
        shortenButton.layer.masksToBounds = true
        shortenButton.layer.cornerRadius = 5.0
        
        urlLabel.text = "URL from clipboard: \(UIPasteboard.generalPasteboard().string!)"
        self.preferredContentSize = CGSizeMake(self.preferredContentSize.width, 70)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
}
