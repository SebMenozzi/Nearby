//
//  InitController.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 19/01/2019.
//  Copyright © 2019 Sebastien Menozzi. All rights reserved.
//

//
//  HomeViewController.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 12/12/2018.
//  Copyright © 2018 Sebastien Menozzi. All rights reserved.
//

import UIKit

class InitController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setGradientBackground(
            startColor: UIColor(r: 67, g: 34, b: 245),
            endColor: UIColor(r: 238, g: 54, b: 166),
            startpoint: CGPoint(x: 0.0, y: 0.0),
            endPoint: CGPoint(x: 1.0, y: 1.0)
        )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkIfUserIsLoggedIn()
    }
    
    func checkIfUserIsLoggedIn() {
        if !AuthService.instance.isLoggedIn {
            AuthService.instance.logout()
            
            let loginController = LoginController()
            loginController.modalTransitionStyle = .crossDissolve
            present(loginController, animated: true, completion: nil)
        } else {
            let userData = UserDataService.instance.userData
            AuthService.instance.redirectAfterAuthentification(viewController: self, user: User(dictionary: userData))
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
