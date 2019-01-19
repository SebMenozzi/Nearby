//
//  SignupUsernameController.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 18/01/2019.
//  Copyright © 2019 Sebastien Menozzi. All rights reserved.
//

import UIKit

class SignupUsernameController: SignupController {
    
    override var user : User {
        didSet {
            titleLabel.text = "Hey \(user.name ?? "John")!"
        }
    }
    
    private let titleLabel = SignupController.createTitleLabel(title: "Hey John!")
    
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.textColor = .white
        textField.placeholder = "Enter a username"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "GothamRounded-Book", size: 30)
        textField.textAlignment = .center
        textField.textContentType = UITextContentType.nickname
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        
        textField.layer.backgroundColor = UIColor.clear.cgColor
        textField.layer.shadowColor = UIColor.white.cgColor
        textField.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        textField.layer.shadowOpacity = 0.4
        textField.layer.shadowRadius = 5.0
        textField.delegate = self
        textField.addTarget(self, action: #selector(usernameChanged), for: .editingChanged)
        return textField
    }()
    
    private let urlLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.font = UIFont(name: "GothamRounded-Medium", size: 16)
        label.text = "username.magik.co"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let shareTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.clear
        textView.textColor = UIColor.white
        textView.font = UIFont(name: "GothamRounded-Book", size: 14)
        textView.text = "Share your link in your snap Story to get anonymous feedback 👻"
        textView.textAlignment = .center
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override func setupLayoutKeyboardWillShow(_ keyboardHeight: CGFloat) {
        self.validationButtonView.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight)
        self.usernameTextField.transform = CGAffineTransform(translationX: 0, y: -(keyboardHeight / 2))
        self.urlLabel.transform = CGAffineTransform(translationX: 0, y: -(keyboardHeight / 2))
        self.shareTextView.transform = CGAffineTransform(translationX: 0, y: -(keyboardHeight / 2))
    }
    
    override func setupLayoutKeyboardWillHide() {
        self.validationButtonView.transform = CGAffineTransform(translationX: 0, y: 0)
        self.usernameTextField.transform = CGAffineTransform(translationX: 0, y: 0)
        self.urlLabel.transform = CGAffineTransform(translationX: 0, y: 0)
        self.shareTextView.transform = CGAffineTransform(translationX: 0, y: 0)
    }
    
    func setupTitleLabel() {
        // width constraints
        titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        // height constraints
        titleLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        // top constraints
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
    }
    
    func setupUsernameTextField() {
        // width constraints
        usernameTextField.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        // height constraints
        usernameTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        // center
        usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        usernameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func setupUrlLabel() {
        // width constraints
        urlLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        // height constraints
        urlLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        // top constraints
        urlLabel.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 10).isActive = true
    }
    
    func setupShareTextView() {
        // width constraints
        shareTextView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        // center constraints
        shareTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        // height constraints
        shareTextView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        // top constraints
        shareTextView.topAnchor.constraint(equalTo: urlLabel.bottomAnchor, constant: 5).isActive = true
    }
    
    override func setupLayout() {
        view.addSubview(titleLabel)
        view.addSubview(usernameTextField)
        view.addSubview(urlLabel)
        view.addSubview(shareTextView)
        
        setupTitleLabel()
        setupUsernameTextField()
        setupUrlLabel()
        setupShareTextView()
        
        // focus name textfield
        usernameTextField.becomeFirstResponder()
        
        validationStatus()
    }
    
    override func next() {
        guard let username = usernameTextField.text else { return }
        user.username = username.lowercased()
        
        goToNext()
    }
    
    @objc func usernameChanged() {
        if let username = usernameTextField.text {
            urlLabel.text = "\(username.isEmpty ? "username" : username.lowercased()).magik.co"
        }
        validationStatus()
    }
    
    private func validationStatus() {
        if let username = usernameTextField.text {
            if username.count >= 3 {
                validationButtonView.alpha = 1
                validationButtonView.isUserInteractionEnabled = true
            } else {
                validationButtonView.alpha = 0.8
                validationButtonView.isUserInteractionEnabled = false
            }
        }
    }
}

extension SignupUsernameController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        if string.count == 0 {
            return true
        }
        
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
        let length: Int = prospectiveText.count
        
        switch textField {
            case usernameTextField:
                return length <= 20
            default:
                return true
        }
    }
}
