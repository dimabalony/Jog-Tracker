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
    
    func addJog(jog: Jog) {
        JogService.instance.addJog(jog: jog) { (success) in
            guard success else { return }
            self.updateJogs()
        }
    }
    
    func editJog(jog: Jog) {
        JogService.instance.editJog(jog: jog) { (success) in
            guard success else { return }
            self.updateJogs()
        }
    }
    
    func deleteJog(jog: Jog) {
        JogService.instance.deleteJog(jog: jog) { (success) in
            guard success else { return }
            self.updateJogs()
        }
    }
    
    func updateJogs() {
        JogService.instance.refreshJogs { (success) in
            guard success else { return }
            NotificationCenter.default.post(name: .updateJogsTable, object: nil)
        }
    }
}
