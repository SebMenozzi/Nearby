//
//  HomeHeader.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 14/01/2019.
//  Copyright © 2019 Sebastien Menozzi. All rights reserved.
//

import UIKit

class WeatherHeader: UICollectionReusableView {
    let containerView = UIView()
    let topView = UIView()
    let bottomView = UIView()
    
    let cityLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 25)
        label.text = "Reims"
        return label
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "602 rooms 🎉"
        return label
    }()
    
    let viewAllLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "View all"
        return label
    }()
    
    let weatherIconLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.font = UIFont(name: "WeatherIcons-Regular", size: 25)
        label.text = "\u{f00d}"
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "Popular Rooms 🔥"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(gesture:)))
        containerView.addGestureRecognizer(tapGesture)
        
        containerView.frame = frame
        
        // set the shadow of the view's layer
        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 5.0
        
        // set the gradient of the containerView's layer
        containerView.setGradientBackground(
            startColor: UIColor(r: 0, g: 114, b: 255),
            //endColor: UIColor(r: 0, g: 198, b: 255)
            endColor: UIColor(r: 207, g: 162, b: 250),
            startpoint: CGPoint(x: 0.0, y: 0.5),
            endPoint: CGPoint(x: 1.0, y: 0.5)
        )
        
        // set the cornerRadius of the containerView's layer
        containerView.makeCorner(withRadius: 10.0)
        
        addSubview(containerView)
        addSubview(titleLabel)
        
        addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: containerView)
        addConstraintsWithFormat(format: "V:|-10-[v0]-20-[v1]-10-|", views: containerView, titleLabel)
        addConstraintsWithFormat(format: "H:|-20-[v0]-10-|", views: titleLabel)
        
        containerView.addSubview(topView)
        containerView.addSubview(bottomView)
        
        addConstraintsWithFormat(format: "H:|-15-[v0]-15-|", views: topView)
        addConstraintsWithFormat(format: "H:|-15-[v0]-15-|", views: bottomView)
        addConstraintsWithFormat(format: "V:|-20-[v0]-10-[v1]-20-|", views: topView, bottomView)
        
        topView.addSubview(cityLabel)
        topView.addSubview(weatherIconLabel)
        
        addConstraintsWithFormat(format: "H:|[v0]-[v1]|", views: cityLabel, weatherIconLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: cityLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: weatherIconLabel)
        
        bottomView.addSubview(infoLabel)
        bottomView.addSubview(viewAllLabel)
        
        addConstraintsWithFormat(format: "H:|[v0]-10-[v1]|", views: infoLabel, viewAllLabel) // 10 padding is weird but it works o_o
        addConstraintsWithFormat(format: "V:|[v0]|", views: infoLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: viewAllLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleTap(gesture: UILongPressGestureRecognizer) {
        print("tap")
    }
}
