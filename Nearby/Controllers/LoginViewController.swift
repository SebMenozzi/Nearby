//
//  LoginViewController.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 12/12/2018.
//  Copyright © 2018 Sebastien Menozzi. All rights reserved.
//

import UIKit
import AccountKit

class LoginViewController: UIViewController {
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var phoneNumberRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor(r: 255, g: 51, b: 102), for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamRounded-Medium", size: 14)
        button.setTitle("SIGNUP NOW", for: .normal)
        button.addTextSpacing(2.0)
        // border radius
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        // shadow
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 2, height: 0)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 8
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleFBAccountKitLogin), for: .touchUpInside)
        button.addTarget(self, action: #selector(handleButtonAnimation(button:)), for: .touchDown)
        return button
    }()
    
    lazy var facebookRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 59, g: 89, b: 152)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamRounded-Medium", size: 14)
        button.setTitle("CONTINUE WITH FACEBOOK", for: .normal)
        button.addTextSpacing(2.0)
        // border radius
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        // shadow
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 2, height: 0)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 8
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleFBLogin), for: .touchUpInside)
        button.addTarget(self, action: #selector(handleButtonAnimation(button:)), for: .touchDown)
        return button
    }()
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let titleTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.clear
        textView.textColor = UIColor.white
        textView.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.thin)
        //textView.font = UIFont(name: "GothamRounded-Light", size: 30)
        textView.textAlignment = .center
        textView.text = "Discover what happens around you."
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let facebookWarningLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 10)
        label.text = "We will never publish anything on your Facebook Account."
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Read Terms", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.thin)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setGradientBackground(
            startColor: UIColor(r: 2, g: 18, b: 35),
            endColor: UIColor(r: 1, g: 36, b: 89),
            startpoint: CGPoint(x: 1.0, y: 0.0),
            endPoint: CGPoint(x: 0.0, y: 1.0)
        )
        
        view.addSubview(logoImageView)
        
        view.addSubview(containerView)
        containerView.addSubview(titleTextView)
        containerView.addSubview(phoneNumberRegisterButton)
        containerView.addSubview(facebookRegisterButton)
        containerView.addSubview(facebookWarningLabel)
        containerView.addSubview(termsButton)
        
        setupcontainerView()
        setupPhoneNumberRegisterButton()
        setupFacebookRegisterButton()
        setupLogoImageView()
        setupTitleTextView()
        setupFacebookWarningLabel()
        setupTermsButton()
    }
    
    func setupLogoImageView() {
        // center horizontally
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        // height constraints
        logoImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        // width constraints
        logoImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        // top constraints
        logoImageView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        // bottom constraints
        logoImageView.bottomAnchor.constraint(equalTo: titleTextView.topAnchor, constant: -15).isActive = true
    }
    
    func setupcontainerView() {
        // center horizontally
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        // width constraints
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -25).isActive = true
        // height constraints
        containerView.heightAnchor.constraint(equalToConstant: 400).isActive = true
    }
    
    func setupTitleTextView() {
        // width constraints
        titleTextView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        // height constraints
        titleTextView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        // bottom constraints
        titleTextView.bottomAnchor.constraint(equalTo: phoneNumberRegisterButton.topAnchor, constant: -25).isActive = true
    }
    
    func setupPhoneNumberRegisterButton() {
        // width constraints
        phoneNumberRegisterButton.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        // height constraints
        phoneNumberRegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        // bottom constraints
        phoneNumberRegisterButton.bottomAnchor.constraint(equalTo: facebookRegisterButton.topAnchor, constant: -15).isActive = true
    }
    
    func setupFacebookRegisterButton() {
        // width constraints
        facebookRegisterButton.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        // height constraints
        facebookRegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        // bottom constraints
        facebookRegisterButton.bottomAnchor.constraint(equalTo: facebookWarningLabel.topAnchor, constant: -10).isActive = true
    }
    
    func setupFacebookWarningLabel() {
        // width constraints
        facebookWarningLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        // height constraints
        facebookWarningLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        // bottom constraints
        facebookWarningLabel.bottomAnchor.constraint(equalTo: termsButton.topAnchor, constant: -30).isActive = true
    }
    
    func setupTermsButton() {
        // width constraints
        termsButton.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        // height constraints
        termsButton.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    @objc func handleFBLogin() {
        AuthService.instance.loginWithFacebook(viewController: self)
    }
    
    @objc func handleFBAccountKitLogin() {
        AuthService.instance.loginWithAccountKit(viewController: self)
    }
    
    @objc func handleButtonAnimation(button: UIButton) {
        button.scale()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension UIButton {
    func addTextSpacing(_ letterSpacing: CGFloat) {
        let attributedString = NSMutableAttributedString(string: (self.titleLabel?.text)!)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: letterSpacing, range: NSRange(location: 0, length: (self.titleLabel?.text!.count)!))
        self.setAttributedTitle(attributedString, for: .normal)
    }
    
    func scale() {
        let scale = CASpringAnimation(keyPath: "transform.scale")
        scale.duration = 0.2
        scale.fromValue = 1.0
        scale.toValue = 0.95
        scale.initialVelocity = 0.7
        scale.damping = 1.0
        scale.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        scale.autoreverses = true
        
        layer.add(scale, forKey: nil)
        
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.2
        flash.fromValue = 1
        flash.toValue = 0.9
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = false
        
        layer.add(flash, forKey: nil)
    }
}

extension LoginViewController: AKFViewControllerDelegate {
    
    func prepareLoginViewController(viewController: AKFViewController) {
        viewController.delegate = self
        
        viewController.uiManager = AKFSkinManager(skinType: .classic, primaryColor: UIColor.black)
    }
    
    func viewControllerDidCancel(_ viewController: (UIViewController & AKFViewController)!) {
        print("Cancelled")
    }
    
    func viewController(_ viewController: (UIViewController & AKFViewController)!, didCompleteLoginWith accessToken: AKFAccessToken!, state: String!) {
        
        let route: ApiRouter = .loginWithAccountKit(accessToken.tokenString)
        
        AuthService.instance.handleAuthentification(route).then { response in
            self.dismiss(animated: true, completion: nil)
        }
    }
}
