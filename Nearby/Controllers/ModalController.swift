//
//  ModalController.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 17/01/2019.
//  Copyright © 2019 Sebastien Menozzi. All rights reserved.
//

import UIKit

class ModalController: NSObject {
    var startingFrame : CGRect?
    let height: CGFloat = 200
    
    lazy var blackView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.9)
        return view
    }()
    
    let modalView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 149, g: 117, b: 255)
        let degrees : Double = -2.0;
        view.transform = CGAffineTransform(rotationAngle: CGFloat(degrees * .pi/180))
        return view
    }()
    
    let modalTitle: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "GothamRounded-Book", size: 18)
        textView.text = "Share your biggest fan status on Twitter for 50,000 bonus?"
        textView.textColor = .white
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.isSelectable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    func showModal(startView: UIView) {
        startingFrame = startView.superview?.convert(startView.frame, to: nil)
        
        if let mainWindow = UIApplication.shared.keyWindow {
            blackView.frame = mainWindow.frame
            blackView.alpha = 0
            mainWindow.addSubview(blackView)
            
            modalView.frame = startingFrame!
            modalView.alpha = 0
            mainWindow.addSubview(modalView)
            
            modalView.addSubview(modalTitle)
            modalTitle.fillSuperview(padding: UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30))
            
            //modalView.addConstraintsWithFormat(format: "H:|-30-[v0]-30-|", views: modalTitle)
            //modalView.addConstraintsWithFormat(format: "V:|-30-[v0]", views: modalTitle)
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            blackView.addGestureRecognizer(tapGestureRecognizer)
            
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.modalView.alpha = 1
                self.modalView.frame = CGRect(x: 0, y: 0, width: mainWindow.frame.width * 2, height: self.height)
                self.modalView.center = mainWindow.center
            }, completion: nil)
        }
    }
    
    func hideModal() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.modalView.frame = self.startingFrame!
            self.modalView.alpha = 0
            self.blackView.alpha = 0
        }) { (didComplete) in
            self.blackView.removeFromSuperview()
            self.modalView.removeFromSuperview()
        }
    }
    
    @objc func handleTap(tapGesture: UITapGestureRecognizer) {
        if tapGesture.view != nil {
            hideModal()
        }
    }
    
    override init() {
        super.init()
    }
}

