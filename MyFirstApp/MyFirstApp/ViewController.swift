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
    
    @IBOutlet weak var textFieldTip: UITextField!
    @IBAction func clickButtonTest(_ sender: AnyObject) {
        let date = Date();
        
        let lastUniqueId = UserDefaults.standard.string(forKey: MyConstants.UniqueIdKey)
        
        if ( (lastUniqueId ?? "").isEmpty )
        {
            _ = beginPark(with: date)
        }
        else
        {
            _ = endPark( for: lastUniqueId!, with: date )
        }
    }
    
    func beginPark( with timestamp: Date ) -> Bool {
        var result = true
        let url = URL(string: MyConstants.ApiBase + MyConstants.BeginParkAPI + "?timeStamp=" + convertDateToString(from: timestamp ) );
        
        var request = URLRequest(url: url! )
        request.httpMethod = "GET"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) {(response, data, error) in
            if let apiRetData = data {
                let respString = String(data: apiRetData, encoding: .utf8 )!;
                self.textViewApiRetVal.text = respString
                
                let json = respString.data(using: .utf8)!
                let decoder = JSONDecoder()
                let beginParkingResponse = try! decoder.decode( BeginParkingResponse.self, from: json)
                
                if ( beginParkingResponse.successful &&
                    beginParkingResponse.uniqueId != nil)
                {
                    self.buttonTest.setTitle( "Parking...", for: UIControlState.normal)
                    self.textFieldTip.text = "Parking since " + self.convertDateForDisplay(from: timestamp)
                    UserDefaults.standard.set(beginParkingResponse.uniqueId, forKey: MyConstants.UniqueIdKey)
                }
            }
            else
            {
                result = false
            }
        }
        
        return result
    }
    
    func endPark( for uniqueid: String, with timestamp: Date ) -> Bool {
        var result = true
        let url = URL(string: MyConstants.ApiBase + MyConstants.EndParkAPI + "?uniqueId=" + uniqueid + "&timeStamp=" + convertDateToString(from: timestamp ) );
        
        var request = URLRequest(url: url! )
        request.httpMethod = "GET"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) {(response, data, error) in
            if let apiRetData = data {
                let respString = String(data: apiRetData, encoding: .utf8 )!;
                self.textViewApiRetVal.text = respString
                
                let json = respString.data(using: .utf8)!
                let decoder = JSONDecoder()
                let endParkingResponse = try! decoder.decode( EndParkingResponse.self, from: json)
                
                if ( endParkingResponse.successful )
                {
                    self.buttonTest.setTitle( "Park", for: UIControlState.normal)
                    self.textFieldTip.text = "Parked Duration: "
                    UserDefaults.standard.removeObject(forKey: MyConstants.UniqueIdKey) // Clear the uniqueId
                }
            }
            else
            {
                result = false
            }
        }
        
        return result
    }
    
    func convertDateToString( from date: Date ) -> String {
        let defaultTimeZoneTimeStamp = convertDateForDisplay(from: date)
        if let time = defaultTimeZoneTimeStamp.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
        {
            return time
        }
        
        return defaultTimeZoneTimeStamp
    }
    
    func convertDateForDisplay( from date: Date ) -> String {
        let formatter = DateFormatter();
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss";
        let defaultTimeZoneTimeStamp = formatter.string(from: date);
        
        return defaultTimeZoneTimeStamp
    }
}
