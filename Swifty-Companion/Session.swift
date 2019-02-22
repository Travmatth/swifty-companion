//
//  Session.swift
//  Swifty-Companion
//
//  Created by Travis Matthews on 2/17/19.
//  Copyright © 2019 Travis Matthews. All rights reserved.
//

import Foundation
import UIKit

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
    
    func getUser(user: String, callback: @escaping (_ user: User?, _ image: UIImage?, _ err: String?) -> Void) {
        dispatch.enter()
        guard token != nil, let req = endpoint.user(user: user, token: token!) else {
            dispatch.leave()
            callback(nil, nil, "Error: could not create user url")
            return
        }
        URLSession.shared.dataTask(with: req) { (data, res, err) in
            guard (res as! HTTPURLResponse).statusCode != 404 else {
                    self.dispatch.leave()
                    callback(nil, nil, "Error: user not found")
                    return
            }
            guard err == nil, let tokenRes = data else {
                self.dispatch.leave()
                callback(nil, nil, "Error: did not receive data")
                return
            }
            if let user = parseUserData(data: tokenRes), user.imageUrl != nil {
                let profileImageUrl = user.imageUrl!
                self.dispatch.enter()
                URLSession.shared.dataTask(with: profileImageUrl) {
                    (data, res, err) in
                    guard err == nil, data != nil else {
                        self.dispatch.leave()
                        callback(nil, nil, "Error downloading profile image")
                        return
                    }
                    callback(user, UIImage(data: data!), nil)
                    self.dispatch.leave()
                }.resume()
            }
            self.dispatch.leave()
        }.resume()
        dispatch.wait()
    }
}
