//
//  ViewController.swift
//  MyFirstApp
//
//  Created by Richard Zhang on 2018/7/5.
//  Copyright © 2018年 Richard Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var textViewApiRetVal: UITextView!
    
    @IBOutlet weak var buttonTest: UIButton!
    
    @IBAction func clickButtonTest(_ sender: AnyObject) {
        let date = Date();
        let formatter = DateFormatter();
        formatter.dateFormat = "yyyy-MM-dd_HH:mm:ss-ZZZ";
        let defaultTimeZoneTimeStamp = formatter.string(from: date);
        let url = URL(string: "http://ec2-18-222-142-104.us-east-2.compute.amazonaws.com:8080/demo4/beginPark?timeStamp=" + (defaultTimeZoneTimeStamp) )
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) {(response, data, error) in
            if let apiRetData = data {
                self.textViewApiRetVal.text = String(data: apiRetData, encoding: .utf8 )
            }
        }
    }
}
