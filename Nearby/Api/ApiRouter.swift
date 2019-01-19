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
    
    public var method: HTTPMethod {
        switch self {
            case .loginWithFacebook, .loginWithAccountKit:
                return .post
        }
    }
    
    public var path: String {
        switch self {
            case .loginWithFacebook:
                return "/auth/withFacebook"
            case .loginWithAccountKit:
                return "/auth/withAccountKit"
        }
    }
        
    public var parameters: Parameters? {
        switch self {
            case .loginWithFacebook(let access_token), .loginWithAccountKit(let access_token):
                return [ "access_token": access_token ]
        }
    }
}
