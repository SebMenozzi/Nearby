//
//  CommentCell.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 16/01/2019.
//  Copyright © 2019 Sebastien Menozzi. All rights reserved.
//

import UIKit

class CommentCell: BaseCell {
    
    var comment: Comment? {
        didSet {
            profileImageView.image = UIImage(named: comment?.user?.picture ?? "default")
            messageTextView.text = comment?.text
        }
    }
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "default")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let bubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 239, g: 240, b: 243)
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "GothamRounded-Book", size: 16)
        textView.text = "Sample text"
        textView.backgroundColor = UIColor.clear
        textView.isEditable = false
        textView.isSelectable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GothamRounded-Medium", size: 14)
        label.text = "gaetan2011"
        label.backgroundColor = UIColor.clear
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(profileImageView)
        addSubview(bubbleView)
        addSubview(nameLabel)
        addSubview(messageTextView)
        
        //bubbleView.addConstraintsWithFormat(format: "H:|[v0]|", views: nameLabel)
        //bubbleView.addConstraintsWithFormat(format: "H:|[v0]|", views: messageTextView)
        //bubbleView.addConstraintsWithFormat(format: "V:|[v0][v1]|", views: nameLabel, messageTextView)
        
        addConstraintsWithFormat(format: "H:|-12-[v0(44)]", views: profileImageView)
        addConstraintsWithFormat(format: "V:|[v0(44)]", views: profileImageView)
        profileImageView.backgroundColor = UIColor.lightGray
    }
}
