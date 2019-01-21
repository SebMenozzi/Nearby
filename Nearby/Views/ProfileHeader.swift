//
//  ProfileHeader.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 04/01/2019.
//  Copyright © 2019 Sebastien Menozzi. All rights reserved.
//

import UIKit

class ProfileHeader: UICollectionReusableView {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "profile_header"))
        imageView.autoresizingMask = [
            .flexibleWidth,
            .flexibleHeight,
            .flexibleBottomMargin,
            .flexibleRightMargin,
            .flexibleLeftMargin,
            .flexibleTopMargin
        ]
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return view
    }()
    
    let followersContainer = UIView()
    
    let followersCount: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .black
        label.font = UIFont(name: "GothamRounded-Medium", size: 17)
        label.text = "258783"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let followersLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .black
        label.font = UIFont(name: "GothamRounded-Book", size: 13)
        label.text = "followers"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let followingsContainer = UIView()
    
    let followingsCount: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .black
        label.font = UIFont(name: "GothamRounded-Medium", size: 17)
        label.text = "854"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let followingsLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .black
        label.font = UIFont(name: "GothamRounded-Book", size: 13)
        label.text = "followings"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        
        addSubview(profileImageView)
        
        addSubview(containerView)
        
        containerView.addSubview(followersContainer)
        followersContainer.addSubview(followersCount)
        followersContainer.addSubview(followersLabel)
        
        containerView.addSubview(followingsContainer)
        followingsContainer.addSubview(followingsCount)
        followingsContainer.addSubview(followingsLabel)
        
        profileImageView.fillSuperview()
        
        setupConstraints()
        
        setupVisualEffectBlur()
    }
    
    private func setupConstraints() {
        addConstraintsWithFormat(format: "H:|[v0]|", views: containerView)
        addConstraintsWithFormat(format: "V:|-[v0(40)]|", views: containerView)
        
        addConstraintsWithFormat(format: "H:|-10-[v0]-10-[v1]", views: followersContainer, followingsContainer)
        addConstraintsWithFormat(format: "V:|-10-[v0(30)]-3-|", views: followersContainer)
        addConstraintsWithFormat(format: "V:|-10-[v0(30)]-3-|", views: followingsContainer)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: followersCount)
        addConstraintsWithFormat(format: "H:|[v0]|", views: followersLabel)
        addConstraintsWithFormat(format: "V:|[v0][v1]|", views: followersCount, followersLabel)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: followingsCount)
        addConstraintsWithFormat(format: "H:|[v0]|", views: followingsLabel)
        addConstraintsWithFormat(format: "V:|[v0][v1]|", views: followingsCount, followingsLabel)
    }
    
    var animator: UIViewPropertyAnimator!
    
    private func setupVisualEffectBlur() {
        animator = UIViewPropertyAnimator(duration: 3, curve: .linear, animations: { [weak self] in
            let blurEffect = UIBlurEffect(style: .light)
            let visualEffectView = UIVisualEffectView(effect: blurEffect)
            
            self?.profileImageView.addSubview(visualEffectView)
            visualEffectView.fillSuperview()
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
