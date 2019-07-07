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
    var jogs: [Jog] {
        return JogService.instance.jogs.reversed()
    }
    
    mutating func addJog(_ jog: Jog) {
        JogService.instance.addJog(jog: jog, completion: {_ in 
            
        })
    }
}
