//
//  BeginParkingResponse.swift
//  MyFirstApp
//
//  Created by Richard Zhang on 2018/7/23.
//  Copyright © 2018年 Richard Zhang. All rights reserved.
//

import Foundation

struct BeginParkingResponse : Codable {
    let successful: Bool
    let message: String?
    let uniqueId: String?
}
