//
//  JogService.swift
//  Jog Tracker
//
//  Created by Дмитрий Болоников on 7/5/19.
//  Copyright © 2019 Дмитрий Болоников. All rights reserved.
//

import Foundation
import Alamofire

class JogService {
    let instance = JogService()
    
    var jogs = [Jog]()
    
    func refreshJogs() {
        //Alamofire.re
    }
}

extension JogService {
    struct Constants {
        var header: [String] {
            return ["Authorization: Bearer \(AuthService.instance.authToken)"]
        }
    }
}
