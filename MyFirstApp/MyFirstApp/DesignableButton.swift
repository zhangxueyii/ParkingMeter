//
//  DesignableButton.swift
//  MyFirstApp
//
//  Created by Richard Zhang on 2018/7/11.
//  Copyright © 2018年 Richard Zhang. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableButton: UIButton {

    @IBInspectable var fillColor: UIColor = UIColor.blue
    @IBInspectable var cornerRadius : CGFloat = 0
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = 100;
        layer.backgroundColor = fillColor.cgColor
    }
}
