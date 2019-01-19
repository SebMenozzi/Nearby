//
//  ApiRouter.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 27/12/2018.
//  Copyright © 2018 Sebastien Menozzi. All rights reserved.
//

import Alamofire

public enum ApiRouter {
    case loginWithFacebook(access_token: String)
    case loginWithAccountKit(access_token: String)
    case updateUser(user: [String: Any])
    
    public var method: HTTPMethod {
        switch self {
            case .loginWithFacebook, .loginWithAccountKit:
                return .post
            case .updateUser:
                return .put
        }
    }
    
    public var path: String {
        switch self {
            case .loginWithFacebook:
                return "/api/auth/withFacebook"
            case .loginWithAccountKit:
                return "/api/auth/withAccountKit"
            case .updateUser:
                return "/api/user"
        }
    }
        
    public var parameters: Parameters? {
        switch self {
            case .loginWithFacebook(let access_token), .loginWithAccountKit(let access_token):
                return [ "access_token": access_token ]
            case .updateUser(let user):
                return [ "user": user ]
        }
    }
}
