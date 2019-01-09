//
//  ApiRouter.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 27/12/2018.
//  Copyright © 2018 Sebastien Menozzi. All rights reserved.
//
import Alamofire

public enum ApiRouter {
    case loginWithFacebook(String)
    case loginWithAccountKit(String)
    
    public var resource: (method: HTTPMethod, route: String) {
        switch self {
            case .loginWithFacebook(let accessToken):
                return (.get, "/auth/loginWithFacebook?access_token=\(accessToken)")
            case .loginWithAccountKit(let accessToken):
                return (.get, "/auth/loginWithAccountKit?access_token=\(accessToken)")
        }
    }
}
