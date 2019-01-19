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
    
    var isLoading: Bool = false
    
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
    
    public func loginWithFacebook(viewController: LoginController) {
        fbSDKManager.logIn(withReadPermissions: ["public_profile", "email", "user_birthday", "user_gender"], from: viewController) {
            (result, error) in
            if error != nil {
                print("Error Facebook Login")
            } else if (result?.isCancelled)! {
                print("Cancelled Facebook Login")
            } else {
                print("Successfully connected to Facebook")
                
                if result!.grantedPermissions != nil && result!.grantedPermissions.contains("email") {
                    if FBSDKAccessToken.current() != nil, let accessToken = FBSDKAccessToken.current().tokenString {
                        let route: ApiRouter = .loginWithFacebook(access_token: accessToken)
                        
                        self.handleAuthentification(viewController: viewController, route: route)
                    }
                }
            }
        }
    }
    
    public func handleAuthentification(viewController: UIViewController, route: ApiRouter) {
        APIClient().request(route).then { response in
            print(response)
            
            guard let token = response["token"] as! String? else { return }
            self.authToken = token
            
            guard let userData = response["user"] as? [String: Any] else { return }
            UserDataService.instance.userData = userData
            
            //self.redirectAfterAuthentification(viewController: viewController, user: User(dictionary: userData))
            //let vc = InitController()
            //vc.modalTransitionStyle = .crossDissolve
            //viewController.present(vc, animated: true, completion: nil)
            viewController.modalTransitionStyle = .crossDissolve
            viewController.dismiss(animated: true, completion: nil)
        }
    }
    
    public func redirectAfterAuthentification(viewController: UIViewController, user: User) {
        print("Name :", user.name)
        print("Username :", user.username)
        print("Birthday :", user.birthday)
        
        if user.name == nil || user.name == "" {
            let vc = SignupNameController()
            vc.user = user
            vc.modalTransitionStyle = .crossDissolve
            viewController.present(vc, animated: true, completion: nil)
        } else if user.username == nil || user.username == "" {
            let vc = SignupUsernameController()
            vc.user = user
            vc.modalTransitionStyle = .crossDissolve
            viewController.present(vc, animated: true, completion: nil)
        } else if user.birthday == nil {
            let vc = SignupBirthdayController()
            vc.user = user
            vc.modalTransitionStyle = .crossDissolve
            viewController.present(vc, animated: true, completion: nil)
        } else {
            let vc = BaseTabBarController()
            vc.modalTransitionStyle = .flipHorizontal
            viewController.present(vc, animated: true, completion: nil)
        }
    }
    
    public func loginWithAccountKit(viewController: LoginController) {
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
