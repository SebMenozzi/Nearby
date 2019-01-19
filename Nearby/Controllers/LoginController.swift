//
//  LoginController.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 12/12/2018.
//  Copyright © 2018 Sebastien Menozzi. All rights reserved.
//

import UIKit
import AccountKit

class LoginController: UIViewController {
    
    lazy var phoneNumberRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        //button.backgroundColor = UIColor(white: 1.0, alpha: 0.15)
        button.backgroundColor = UIColor(white: 1.0, alpha: 1)
        
        //button.layer.borderWidth = 2
        //button.layer.borderColor = UIColor(white: 1.0, alpha: 0.7).cgColor
        
        //button.setTitleColor(UIColor(r: 255, g: 255, b: 255), for: .normal)
        button.setTitleColor(UIColor(r: 255, g: 73, b: 122), for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamRounded-Medium", size: 20)
        button.setTitle("SIGNUP NOW", for: .normal)
        button.addTextSpacing(2.0)
        // shadow
        button.layer.shadowColor = UIColor.white.cgColor
        button.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 5.0
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleFBAccountKitLogin), for: .touchUpInside)
        
        button.alpha = 0.6
        return button
    }()
    
    lazy var facebookRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 59, g: 89, b: 152)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamRounded-Medium", size: 16)
        button.setTitle("CONTINUE WITH FACEBOOK", for: .normal)
        button.addTextSpacing(2.0)
        // shadow
        button.layer.shadowColor = UIColor.white.cgColor
        button.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 5.0
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleFBLogin), for: .touchUpInside)
        
        button.alpha = 0.6
        return button
    }()
    
    let logoLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.font = UIFont(name: "GothamRounded-Medium", size: 35)
        label.text = "Login."
        //label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.clear
        textView.textColor = UIColor.white
        //textView.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.thin)
        textView.font = UIFont(name: "GothamRounded-Book", size: 30)
        //textView.textAlignment = .center
        textView.text = "Express yourself, show your magic ✨"
        
        textView.layer.backgroundColor = UIColor.clear.cgColor
        textView.layer.shadowColor = UIColor.white.cgColor
        textView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        textView.layer.shadowOpacity = 0.4
        textView.layer.shadowRadius = 5.0
        
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setGradientBackground(
            startColor: UIColor(r: 67, g: 34, b: 245),
            endColor: UIColor(r: 238, g: 54, b: 166),
            startpoint: CGPoint(x: 0.0, y: 0.0),
            endPoint: CGPoint(x: 1.0, y: 1.0)
        )
        
        //view.addSubview(logoImageView)
        view.addSubview(logoLabel)
        
        view.addSubview(titleTextView)
        view.addSubview(phoneNumberRegisterButton)
        view.addSubview(facebookRegisterButton)
        
        setupLogoLabel()
        
        setupPhoneNumberRegisterButton()
        setupFacebookRegisterButton()
        setupTitleTextView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        phoneNumberRegisterButton.fadeIn(withDuration: 1)
        facebookRegisterButton.fadeIn(withDuration: 1)
        
        //titleTextView.startShimmering(count: -1)
    }
    
    func setupLogoLabel() {
        // width constraints
        logoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        // height constraints
        logoLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        // top constraints
        logoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
    }
    
    func setupTitleTextView() {
        // width constraints
        titleTextView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        titleTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        // height constraints
        titleTextView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        // bottom constraints
        titleTextView.bottomAnchor.constraint(equalTo: phoneNumberRegisterButton.topAnchor).isActive = true
    }
    
    func setupPhoneNumberRegisterButton() {
        // width constraints
        phoneNumberRegisterButton.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        // height constraints
        phoneNumberRegisterButton.heightAnchor.constraint(equalToConstant: 82).isActive = true
        // bottom constraints
        phoneNumberRegisterButton.bottomAnchor.constraint(equalTo: facebookRegisterButton.topAnchor).isActive = true
    }
    
    func setupFacebookRegisterButton() {
        // width constraints
        facebookRegisterButton.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        // height constraints
        facebookRegisterButton.heightAnchor.constraint(equalToConstant: 82).isActive = true
        // bottom constraints
        facebookRegisterButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @objc func handleFBLogin() {
        AuthService.instance.loginWithFacebook(viewController: self)
    }
    
    @objc func handleFBAccountKitLogin() {
        AuthService.instance.loginWithAccountKit(viewController: self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension LoginController: AKFViewControllerDelegate {
    
    func prepareLoginViewController(viewController: AKFViewController) {
        viewController.delegate = self
        
        viewController.uiManager = AKFSkinManager(skinType: .classic, primaryColor: UIColor.black)
    }
    
    func viewControllerDidCancel(_ viewController: (UIViewController & AKFViewController)!) {
        print("Cancel Account Kit")
        AuthService.instance.isLoading = false
    }
    
    func viewController(_ viewController: (UIViewController & AKFViewController)!, didCompleteLoginWith accessToken: AKFAccessToken!, state: String!) {
        
        let route: ApiRouter = .loginWithAccountKit(access_token: accessToken.tokenString)
        
        AuthService.instance.handleAuthentification(viewController: self, route: route)
    }
}
