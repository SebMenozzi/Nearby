//
//  SignupController.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 18/01/2019.
//  Copyright © 2019 Sebastien Menozzi. All rights reserved.
//


import UIKit
import AccountKit

class SignupController: UIViewController {
    
    var user = User(dictionary: [:])
    
    static func createTitleLabel(title: String) -> UILabel {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.font = UIFont(name: "GothamRounded-Medium", size: 25)
        label.text = title
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    /* Validation Button */
    
    lazy var validationButtonView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1.0, alpha: 1)
        // shadow
        view.layer.shadowColor = UIColor.white.cgColor
        view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 5.0
        view.translatesAutoresizingMaskIntoConstraints = false
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleValidation))
        view.addGestureRecognizer(tapGestureRecognizer)
        return view
    }()
    
    private let validationLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor(r: 255, g: 73, b: 122)
        label.textAlignment = .center
        label.font = UIFont(name: "GothamRounded-Medium", size: 16)
        label.text = "CONTINUE"
        label.addTextSpacing(2.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var loadingShapeLayer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setGradientBackground(
            startColor: UIColor(r: 67, g: 34, b: 245),
            endColor: UIColor(r: 238, g: 54, b: 166),
            startpoint: CGPoint(x: 0.0, y: 0.0),
            endPoint: CGPoint(x: 1.0, y: 1.0)
        )
        
        setupLayout()
        
        view.addSubview(validationButtonView)
        validationButtonView.addSubview(validationLabel)
        setupButtonValidation()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setupLayout() {
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupCircleLayers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        
        let keyboardHeight: CGFloat
        if #available(iOS 11.0, *) {
            keyboardHeight = keyboardFrame.cgRectValue.height - view.safeAreaInsets.bottom
        } else {
            keyboardHeight = keyboardFrame.cgRectValue.height
        }
        
        setupLayoutKeyboardWillShow(keyboardHeight)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        setupLayoutKeyboardWillHide()
    }
    
    func setupLayoutKeyboardWillShow (_ keyboardHeight: CGFloat) {
        
    }
    
    func setupLayoutKeyboardWillHide () {
        
    }
    
    private func setupCircleLayers() {
        loadingShapeLayer = createCircleShapeLayer()
        validationButtonView.layer.addSublayer(loadingShapeLayer)
    }
    
    private func createCircleShapeLayer() -> CAShapeLayer {
        let center = CGPoint.zero
        let circularPath = UIBezierPath(arcCenter: center, radius: 15, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor(r: 255, g: 73, b: 122).cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 4
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeEnd = 0
        shapeLayer.position = CGPoint(x: validationButtonView.frame.width / 2, y: validationButtonView.frame.height / 2)
        shapeLayer.transform = CATransform3DMakeRotation(-1 * .pi / 2, 0, 0, 1)
        return shapeLayer
    }
    
    func setupButtonValidation() {
        // width constraints
        validationButtonView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        // height constraints
        validationButtonView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        // bottom constraints
        validationButtonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        validationLabel.centerXAnchor.constraint(equalTo: validationButtonView.centerXAnchor).isActive = true
        validationLabel.centerYAnchor.constraint(equalTo: validationButtonView.centerYAnchor).isActive = true
    }
    
    fileprivate func animateLoadingCircle() {
        validationLabel.isHidden = true
        validationButtonView.isUserInteractionEnabled = false
        
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            self.validationLabel.isHidden = false
            self.validationButtonView.isUserInteractionEnabled = true
            self.next()
        })
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 0.3
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = true
        loadingShapeLayer.add(basicAnimation, forKey: "basic")
        
        CATransaction.commit()
    }
    
    @objc private func handleValidation(tapGesture: UITapGestureRecognizer) {
        animateLoadingCircle()
    }
    
    func goToNext() {
        AuthService.instance.redirectAfterAuthentification(viewController: self, user: user)
    }
    
    func next() {
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
