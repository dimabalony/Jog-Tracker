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
    var timeSince1970: TimeInterval
    var date: String {
        return fmt.string(from: Date(timeIntervalSince1970: timeSince1970))
    }
    let time: Int
    let id: Int?
    let userId: String?
    private let fmt: DateFormatter = {
        let fmt = DateFormatter()
        fmt.dateFormat = "dd.MM.yyyy"
        return fmt
    }()
    
    init?(distance: Double, time: Int, date: String) {
        self.distance = distance
        self.time = time
        guard let date = fmt.date(from: date) else { return nil }
        self.timeSince1970 = date.timeIntervalSince1970
    }

    init(distance: Double, time: Int, timeSince1970: TimeInterval) {
        self.distance = distance
        self.time = time
        self.timeSince1970 = timeSince1970
    }
}
