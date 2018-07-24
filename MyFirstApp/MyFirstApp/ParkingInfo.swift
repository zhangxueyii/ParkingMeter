//
//  ParkingInfo.swift
//  MyFirstApp
//
//  Created by Richard Zhang on 7/24/18.
//  Copyright © 2018 Richard Zhang. All rights reserved.
//

import Foundation

struct ParkingInfo : Codable {
    let unique_id: String?
    let beginTime: Date
    let endTime: Date?
    let isDel: Bool
}
