//
//  JogTracker.swift
//  Jog Tracker
//
//  Created by Дмитрий Болоников on 7/5/19.
//  Copyright © 2019 Дмитрий Болоников. All rights reserved.
//

import Foundation

struct JogTracker {
    var isLoggedIn: Bool {
        return AuthService.instance.isLoggedIn
    }
    private(set) var jogs: [Jog]
    
    mutating func addJog(_ jog: Jog) {
        guard jogs.filter( { $0.uid == jog.uid } ).isEmpty else { return }
        jogs.append(jog)
    }
}
