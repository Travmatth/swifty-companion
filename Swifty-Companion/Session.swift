//
//  Session.swift
//  Swifty-Companion
//
//  Created by Travis Matthews on 2/17/19.
//  Copyright © 2019 Travis Matthews. All rights reserved.
//

import Foundation

class Session {
    var token: String?
    private let dispatch = DispatchGroup()
    private let endpoint = Endpoints()
    
    init() {}
    
    func startOAuthFlow() {
        dispatch.enter()
        guard let req = endpoint.login() else {
            print("Error: could not create login url")
            dispatch.leave()
            return
        }
        URLSession.shared.dataTask(with: req) { (data, res, err) in
            guard err == nil, let tokenRes = data else {
                print("Error: did not receive data")
                self.dispatch.leave()
                return
            }
            do {
                guard let tokenJSON = try JSONSerialization.jsonObject(with: tokenRes, options: .mutableContainers) as? NSDictionary else {
                    print("Error: could not convert token from json")
                    self.dispatch.leave()
                    return
                }
                self.token = tokenJSON["access_token"] as! String
            } catch {
                print("Error: could not retrieve token")
            }
            self.dispatch.leave()
            }.resume()
        dispatch.wait()
    }
    
    func getUser(user: String, callback: @escaping (_ user: User) -> Void) {
        dispatch.enter()
        guard token != nil, let req = endpoint.user(user: user, token: token!) else {
            print("Error: could not create user url")
            dispatch.leave()
            return
        }
        URLSession.shared.dataTask(with: req) { (data, res, err) in
            guard err == nil, let tokenRes = data else {
                print("Error: did not receive data")
                self.dispatch.leave()
                return
            }
            if let user = parseUserData(data: tokenRes) {
                callback(user)
            }
            self.dispatch.leave()
        }.resume()
        dispatch.wait()
    }
}
