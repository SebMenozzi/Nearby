//
//  NewRoomController.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 28/12/2018.
//  Copyright © 2018 Sebastien Menozzi. All rights reserved.
//

import UIKit

class NewRoomController: UIViewController {
    
    let visibilityView = UIView()
    
    let visibilityTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "VISIBILITY"
        return label
    }()
    
    let publicButton: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1.0, alpha: 0.1)
        return view
    }()
    
    let publicLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "Public"
        return label
    }()
    
    let privateButton: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1.0, alpha: 0.1)
        view.alpha = CGFloat(0.6)
        return view
    }()
    
    let privateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "Private"
        return label
    }()
    
    let visibilityInfo: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.thin)
        label.text = "Anyone can join! 🎉"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setGradientBackground(
            startColor: UIColor(r: 0, g: 114, b: 255),
            endColor: UIColor(r: 163, g: 91, b: 205),
            startpoint: CGPoint(x: 0.5, y: 0.0),
            endPoint: CGPoint(x: 0.5, y: 1.0)
        )
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationController?.navigationBar.backgroundColor = UIColor.clear
        
        view.addSubview(visibilityView)
        visibilityView.addSubview(visibilityTitle)
        
        visibilityView.addSubview(publicButton)
        publicButton.addSubview(publicLabel)
        
        visibilityView.addSubview(privateButton)
        privateButton.addSubview(privateLabel)
        
        visibilityView.addSubview(visibilityInfo)
        
        setupVisibilitySection()
    }
    
    func setupVisibilitySection() {
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: visibilityView)
        visibilityView.addConstraintsWithFormat(format: "H:|-10-[v0]|", views: visibilityTitle)
        visibilityView.addConstraintsWithFormat(format: "H:|[v0]|", views: publicButton)
        publicButton.addConstraintsWithFormat(format: "H:|-15-[v0]|", views: publicLabel)
        visibilityView.addConstraintsWithFormat(format: "H:|[v0]|", views: privateButton)
        privateButton.addConstraintsWithFormat(format: "H:|-15-[v0]|", views: privateLabel)
        visibilityView.addConstraintsWithFormat(format: "H:|-10-[v0]|", views: visibilityInfo)
        
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: visibilityView)
        visibilityView.addConstraintsWithFormat(format: "V:|-80-[v0]-3-[v1(50)][v2(50)]-10-[v3]", views: visibilityTitle, publicButton, privateButton, visibilityInfo)
        publicButton.addConstraintsWithFormat(format: "V:|[v0]|", views: publicLabel)
        privateButton.addConstraintsWithFormat(format: "V:|[v0]|", views: privateLabel)
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
}
