//
//  Endpoints.swift
//  Swifty-Companion
//
//  Created by Travis Matthews on 2/18/19.
//  Copyright © 2019 Travis Matthews. All rights reserved.
//

import Foundation

class Endpoints {
    private let userUrl = "https://api.intra.42.fr/v2/users/"
    private let loginUrl = "https://api.intra.42.fr/oauth/token?grant_type=client_credentials"
    private let uid = "7038cde87efda3c1ad4c2650046843b7aeae4c5bb44025c4089f22bae02e7af8"
    private let secret = "d9d92b33a51c5b5c6ab45e0745dd1d0070836c2143101a4059e3da4bbd674f5f"
    
    init() {}
    
    func login() -> URLRequest? {
        guard let url = URL(string: loginUrl) else { return nil }
        let bearer = ((uid + ":" + secret).data(using: String.Encoding.utf8))!.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.setValue("Basic " + bearer, forHTTPHeaderField: "Authorization")
        return req
    }
    
    func user(user: String, token: String) -> URLRequest? {
        let urlStr = userUrl + user
        guard let url = URL(string: urlStr) else { return nil }
        let bearer = "Bearer " + token
        var req = URLRequest(url: url)
        req.httpMethod = "GET"
        req.setValue(bearer, forHTTPHeaderField: "Authorization")
        print("requesting: \(urlStr)")
        return req
    }
}
