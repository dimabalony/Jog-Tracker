//
//  Jog.swift
//  Jog Tracker
//
//  Created by Дмитрий Болоников on 7/5/19.
//  Copyright © 2019 Дмитрий Болоников. All rights reserved.
//

import Foundation

struct Jog {
    let uid: String
    let userId: Int
    let distance: Double
    let time: Int
    let date: String
    
    init(uid: String = UUID().uuidString, userId: Int, distance: Double, time: Int, date: String) {
        self.uid = uid
        self.userId = userId
        self.distance = distance
        self.time = time
        self.date = date
    }
}
