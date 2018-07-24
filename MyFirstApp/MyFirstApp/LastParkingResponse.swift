//
//  LastParkingResponse.swift
//  MyFirstApp
//
//  Created by Richard Zhang on 7/24/18.
//  Copyright © 2018 Richard Zhang. All rights reserved.
//

import Foundation

struct LastParkingResponse : Codable {
    let successful: Bool
    let message: String?
    let unique_id: String?
    let beginTime: Date?
    let endTime: Date?
}
