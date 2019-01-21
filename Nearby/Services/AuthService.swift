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
        /*
        get {
            do {
                let jwt: JSONWebToken = try JSONWebToken(string : self.authToken)
                
                let validator = RegisteredClaimValidator.expiration & RegisteredClaimValidator.notBefore.optional
                
                return validator.validateToken(jwt).isValid
            } catch {
                return false
            }
        }
        */
        return true
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
        APIClient().request(route: route).then { response in
            print(response)
            
            guard let token = response["token"] as! String? else { return }
            self.authToken = token
            
            guard let userData = response["user"] as? [String: Any] else { return }
            UserDataService.instance.userData = User(dictionary: userData).toDictionary()
            
            self.redirectAfterAuthentification(vc: viewController, user: User(dictionary: userData))
        }
    }
    
    fileprivate func presentSignupController(sourceVc: UIViewController, destVc: SignupController, user: User) {
        destVc.user = user
        destVc.modalTransitionStyle = .crossDissolve
        sourceVc.present(destVc, animated: true, completion: nil)
    }
    
    public func redirectAfterAuthentification(vc: UIViewController, user: User) {
        if user.name == nil || user.name == "" {
            presentSignupController(sourceVc: vc, destVc: SignupNameController(), user: user)
        } else if user.username == nil || user.username == "" {
            presentSignupController(sourceVc: vc, destVc: SignupUsernameController(), user: user)
        } else if user.birthday == nil || user.birthday == "" {
            presentSignupController(sourceVc: vc, destVc: SignupBirthdayController(), user: user)
        } else {
            let newUserData = user.toDictionary()
            let currentUserData = UserDataService.instance.userData
            let areUsersEqual = NSDictionary(dictionary: currentUserData).isEqual(to: newUserData)
            
            if !areUsersEqual {
                print("User updated :", newUserData)
                updateUser(user: newUserData)
            }
            
            let connectesVc = BaseTabBarController()
            connectesVc.modalTransitionStyle = .crossDissolve
            vc.present(connectesVc, animated: true, completion: nil)
        }
    }
    
    fileprivate func updateUser(user: [String: Any]) {
        let route: ApiRouter = .updateUser(user: user)
        
        APIClient().request(route: route).then { response in
            guard let userData = response["user"] as? [String: Any] else { return }
            print(userData)
            UserDataService.instance.userData = User(dictionary: userData).toDictionary()
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
