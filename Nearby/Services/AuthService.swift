//
//  AuthService.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 30/12/2018.
//  Copyright © 2018 Sebastien Menozzi. All rights reserved.
//

import Foundation
import FBSDKLoginKit
import AccountKit
import Hydra
import SwiftKeychainWrapper
import KTVJSONWebToken

class AuthService {
    
    static let instance = AuthService()
    
    var authToken: String {
        get {
            return KeychainWrapper.standard.string(forKey: TOKEN_KEY) ?? ""
        }
        set {
            KeychainWrapper.standard.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var isLoggedIn : Bool {
        get {
            do {
                let jwt: JSONWebToken = try JSONWebToken(string : self.authToken)
                
                let validator = RegisteredClaimValidator.expiration & RegisteredClaimValidator.notBefore.optional
                
                return validator.validateToken(jwt).isValid
            } catch {
                return false
            }
        }
    }
    
    private let fbSDKManager: FBSDKLoginManager = FBSDKLoginManager()
    private let accountKitManager: AKFAccountKit! = AKFAccountKit(responseType: .accessToken)
    
    // request the token via the Api and save it
    public func handleAuthentification(_ route: ApiRouter) -> Promise<JSON> {
        return APIClient().request(route).then { response in
            self.authToken = response["token"] as! String
        }
    }
    
    public func loginWithFacebook(viewController: LoginViewController) {
        fbSDKManager.logIn(withReadPermissions: ["public_profile", "email", "user_birthday", "user_gender"], from: viewController) {
            (result, error) in
            if error != nil {
                print("error")
            } else if (result?.isCancelled)! {
                print("Cancelled")
            } else {
                print("Successfully connected to Facebook")
                
                if result!.grantedPermissions != nil && result!.grantedPermissions.contains("email") {
                    if FBSDKAccessToken.current() != nil, let accessToken = FBSDKAccessToken.current().tokenString {
                        let route: ApiRouter = .loginWithFacebook(accessToken)
                        
                        self.handleAuthentification(route).then { response in
                            viewController.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            }
        }
    }
    
    public func loginWithAccountKit(viewController: LoginViewController) {
        let inputState = UUID().uuidString
        
        let vc = accountKitManager.viewControllerForPhoneLogin(with: nil, state: inputState) as AKFViewController
        vc.enableSendToFacebook = true
        
        // prepare accountKitViewController
        viewController.prepareLoginViewController(viewController: vc)
        
        // show the accountKitViewController as a presentation modal
        viewController.present(vc as! UIViewController, animated: true, completion: nil)
    }
    
    public func logout() {
        self.authToken = ""
    }
    
}
