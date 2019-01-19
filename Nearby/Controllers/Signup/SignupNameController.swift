//
//  SignupNameController.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 18/01/2019.
//  Copyright © 2019 Sebastien Menozzi. All rights reserved.
//

import UIKit

class SignupNameController: SignupController {
    
    private let titleLabel = SignupController.createTitleLabel(title: "So what's your name?")
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.textColor = .white
        textField.placeholder = "Your name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "GothamRounded-Book", size: 35)
        textField.textAlignment = .center
        textField.textContentType = UITextContentType.givenName
        textField.autocorrectionType = .no
        
        textField.layer.backgroundColor = UIColor.clear.cgColor
        textField.layer.shadowColor = UIColor.white.cgColor
        textField.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        textField.layer.shadowOpacity = 0.4
        textField.layer.shadowRadius = 5.0
        textField.delegate = self
        textField.addTarget(self, action: #selector(nameChanged), for: .editingChanged)
        return textField
    }()
    
    override func setupLayoutKeyboardWillShow(_ keyboardHeight: CGFloat) {
        self.validationButtonView.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight)
        self.nameTextField.transform = CGAffineTransform(translationX: 0, y: -(keyboardHeight / 2))
    }
    
    override func setupLayoutKeyboardWillHide() {
        self.validationButtonView.transform = CGAffineTransform(translationX: 0, y: 0)
        self.nameTextField.transform = CGAffineTransform(translationX: 0, y: 0)
    }
    
    func setupTitleLabel() {
        // width constraints
        titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        // height constraints
        titleLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        // top constraints
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
    }
    
    func setupNameTextField() {
        // width constraints
        nameTextField.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        // height constraints
        nameTextField.heightAnchor.constraint(equalToConstant: 200).isActive = true
        // center
        nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    override func setupLayout() {
        view.addSubview(titleLabel)
        view.addSubview(nameTextField)
        
        setupTitleLabel()
        setupNameTextField()
        
        // focus name textfield
        nameTextField.becomeFirstResponder()
        
        validationStatus()
    }
    
    override func next() {
        guard let name = nameTextField.text else { return }
        user.name = name.trimmingCharacters(in: .whitespaces)
        
        goToNext()
    }
    
    @objc func nameChanged() {
        validationStatus()
    }
    
    private func validationStatus() {
        if let name = nameTextField.text {
            if name.count >= 3 {
                validationButtonView.alpha = 1
                validationButtonView.isUserInteractionEnabled = true
            } else {
                validationButtonView.alpha = 0.8
                validationButtonView.isUserInteractionEnabled = false
            }
        }
    }
}

extension SignupNameController : UITextFieldDelegate {
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
            case nameTextField:
                return length <= 20
            default:
                return true
        }
    }
}
