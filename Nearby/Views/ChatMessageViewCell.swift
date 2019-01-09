//
//  ChatMessageViewCell.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 11/12/2018.
//  Copyright © 2018 Sebastien Menozzi. All rights reserved.
//

import UIKit

class ChatMessageViewCell: BaseCell {
    
    let messageTextView: UITextView = {
        let textview = UITextView()
        textview.font = UIFont.systemFont(ofSize: 18)
        textview.text = "Sample text"
        textview.backgroundColor = UIColor.clear
        return textview
    }()
    
    let textBubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "default")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(textBubbleView)
        addSubview(messageTextView)
        
        addSubview(profileImageView)
        addConstraintsWithFormat(format: "H:|-12-[v0(40)]", views: profileImageView)
        addConstraintsWithFormat(format: "V:|[v0(40)]", views: profileImageView)
        profileImageView.backgroundColor = UIColor.lightGray
    }
}
