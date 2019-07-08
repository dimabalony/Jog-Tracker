//
//  Jog.swift
//  Jog Tracker
//
//  Created by Дмитрий Болоников on 7/5/19.
//  Copyright © 2019 Дмитрий Болоников. All rights reserved.
//

import Foundation

struct Jog {
    let distance: Double
    let time: Int
    let timeSince1970: TimeInterval
    var date: String {
        return fmt.string(from: Date(timeIntervalSince1970: timeSince1970))
    }
    let userId: String?
    let id: Int?
    private let fmt: DateFormatter = {
        let fmt = DateFormatter()
        fmt.dateFormat = "dd.MM.yyyy"
        return fmt
    }()
    
    init?(distance: Double, time: Int, date: String, userId: String? = nil, id: Int? = nil) {
        self.distance = distance
        self.time = time
        guard let date = fmt.date(from: date) else { return nil }
        self.timeSince1970 = date.timeIntervalSince1970
        self.userId = userId
        self.id = id
    }

    init(distance: Double, time: Int, timeSince1970: TimeInterval, userId: String? = nil, id: Int? = nil) {
        self.distance = distance
        self.time = time
        self.timeSince1970 = timeSince1970
        self.userId = userId
        self.id = id
    }
}


