//
//  SignupBirthdayController.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 18/01/2019.
//  Copyright © 2019 Sebastien Menozzi. All rights reserved.
//

import UIKit

class SignupBirthdayController: SignupController {
    
    private let titleLabel = SignupController.createTitleLabel(title: "When is your birthday? 🎂")
    
    func dateTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.textColor = .white
        textField.placeholder = placeholder
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "GothamRounded-Book", size: 30)
        textField.textAlignment = .center
        textField.textContentType = UITextContentType.nickname
        textField.autocorrectionType = .no
        textField.keyboardType = .numberPad
        
        textField.layer.backgroundColor = UIColor.clear.cgColor
        textField.layer.shadowColor = UIColor.white.cgColor
        textField.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        textField.layer.shadowOpacity = 0.4
        textField.layer.shadowRadius = 5.0
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let length = textField.text?.count else { return }
        
        if textField == dayTextField {
            if length >= 2 {
                monthTextField.becomeFirstResponder()
            }
        }
        else if textField == monthTextField {
           if length >= 2 {
                yearTextField.becomeFirstResponder()
            }
        }
        else if textField == yearTextField {
            if length >= 4 {
                self.view.resignFirstResponder()
            }
        }
        validationStatus()
    }
    
    private lazy var dayTextField: UITextField = dateTextField(placeholder: "DD")
    private lazy var monthTextField: UITextField = dateTextField(placeholder: "MM")
    private lazy var yearTextField: UITextField = dateTextField(placeholder: "YYYY")
    
    private lazy var birthdayContainerView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dayTextField, monthTextField, yearTextField])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func setupLayoutKeyboardWillShow(_ keyboardHeight: CGFloat) {
        self.validationButtonView.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight)
        self.birthdayContainerView.transform = CGAffineTransform(translationX: 0, y: -(keyboardHeight / 2))
    }
    
    override func setupLayoutKeyboardWillHide() {
        self.validationButtonView.transform = CGAffineTransform(translationX: 0, y: 0)
        self.birthdayContainerView.transform = CGAffineTransform(translationX: 0, y: 0)
    }
    
    func setupTitleLabel() {
        // width constraints
        titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        // height constraints
        titleLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        // top constraints
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
    }
    
    func setupBirthdayContainerView() {
        // height constraints
        birthdayContainerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        // center
        birthdayContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        birthdayContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    override func setupLayout() {
        view.addSubview(titleLabel)
        view.addSubview(birthdayContainerView)
        birthdayContainerView.addSubview(dayTextField)
        birthdayContainerView.addSubview(monthTextField)
        birthdayContainerView.addSubview(yearTextField)
        
        setupTitleLabel()
        setupBirthdayContainerView()
        
        // focus day textfield
        dayTextField.becomeFirstResponder()
        
        validationStatus()
    }
    
    func from(year: Int, month: Int, day: Int) -> Date {
        let gregorianCalendar = NSCalendar(calendarIdentifier: .gregorian)!
        
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        let date = gregorianCalendar.date(from: dateComponents)!
        return date
    }
    
    override func next() {
        guard let day = Int(dayTextField.text ?? "0") else { return }
        guard let month = Int(monthTextField.text ?? "0") else { return }
        guard let year = Int(yearTextField.text ?? "0") else { return }
        
        user.birthday = from(year: year, month: month, day: day)
        
        goToNext()
    }
    
    private func validationStatus() {
        guard let day = dayTextField.text else { return }
        guard let month = monthTextField.text else { return }
        guard let year = yearTextField.text else { return }
        
        if day.count == 2 && month.count == 2 && year.count == 4 {
            validationButtonView.alpha = 1
            validationButtonView.isUserInteractionEnabled = true
        } else {
            validationButtonView.alpha = 0.8
            validationButtonView.isUserInteractionEnabled = false
        }
    }
}

extension SignupBirthdayController : UITextFieldDelegate {
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
            case dayTextField, monthTextField:
                return length <= 2
            case yearTextField:
                return length <= 4
            default:
                return true
        }
    }
}


