//
//  JogService.swift
//  Jog Tracker
//
//  Created by Дмитрий Болоников on 7/5/19.
//  Copyright © 2019 Дмитрий Болоников. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class JogService {
    static let instance = JogService()
    
    var jogs = [Jog]()
    
    func refreshJogs(completion: @escaping (_ success: Bool) -> ()) {
        Alamofire.request("https://jogtracker.herokuapp.com/api/v1/data/sync", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HTTPComponents.bearerHeader).responseJSON { (response) in
            guard response.result.error == nil, let data = response.data else {
                completion(false)
                return
            }
            do {
                let json = try JSON(data: data)
                let jogs = json["response"]["jogs"].arrayValue
                self.jogs = []
                for jogJSON in jogs {
                    let distance = jogJSON["distance"].doubleValue
                    let time = jogJSON["time"].intValue
                    let timeSince1970 = jogJSON["date"].doubleValue
                    let userId = jogJSON["user_id"].stringValue
                    let id = jogJSON["id"].intValue
                    let jog = Jog(distance: distance, time: time, timeSince1970: timeSince1970, userId: userId, id: id)
                    self.jogs.append(jog)
                }
                completion(true)
            } catch(let exception) {
                completion(false)
                debugPrint(exception)
            }
        }
    }
    
    func addJog(jog: Jog, completion: @escaping (_ success: Bool) -> ()) {
        let body: [String: Any] = [
            "date": jog.date,
            "time": jog.time,
            "distance": jog.distance
        ]
        Alamofire.request("https://jogtracker.herokuapp.com/api/v1/data/jog", method: .post, parameters: body, encoding: JSONEncoding.default, headers: HTTPComponents.bearerHeader).responseJSON { (response) in
            guard response.result.error == nil, let data = response.data else {
                completion(false)
                return
            }
            do {
                let json = try JSON(data: data)
                print(json)
                completion(true)
            } catch(let exception) {
                completion(false)
                debugPrint(exception)
            }
        }
    }
    
    func editJog(jog: Jog, completion: @escaping (_ success: Bool) -> ()) {
        guard let jogId = jog.id, let userId = jog.userId else { return }
        let body: [String: Any] = [
            "date": jog.date,
            "time": jog.time,
            "distance": jog.distance,
            "jog_id": jogId,
            "user_id": userId
        ]
        Alamofire.request("https://jogtracker.herokuapp.com/api/v1/data/jog", method: .put, parameters: body, encoding: JSONEncoding.default, headers: HTTPComponents.bearerHeader).responseJSON { (response) in
            guard response.result.error == nil, let data = response.data else {
                completion(false)
                return
            }
            do {
                let json = try JSON(data: data)
                print(json)
                completion(true)
            } catch(let exception) {
                completion(false)
                debugPrint(exception)
            }
        }
    }
    
    func deleteJog(jog: Jog, completion: @escaping (_ success: Bool) -> ()) {
        guard let jogId = jog.id, let userId = jog.userId else { return }
        let body: [String: Any] = [
            "jog_id": jogId,
            "user_id": userId
        ]
        Alamofire.request("https://jogtracker.herokuapp.com/api/v1/data/jog", method: .delete, parameters: body, encoding: JSONEncoding.default, headers: HTTPComponents.bearerHeader).responseJSON { (response) in
            guard response.result.error == nil, let data = response.data else {
                completion(false)
                return
            }
            do {
                let json = try JSON(data: data)
                print(json)
                completion(true)
            } catch(let exception) {
                completion(false)
                debugPrint(exception)
            }
        }
    }
}

extension JogService {
    struct HTTPComponents {
        static var bearerHeader: [String: String] {
            guard let authToken = AuthService.instance.authToken else { return [:] }
            return ["Authorization": "Bearer \(authToken)"]
        }
    }
}
