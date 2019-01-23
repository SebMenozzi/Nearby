//
//  PostCell.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 15/01/2019.
//  Copyright © 2019 Sebastien Menozzi. All rights reserved.
//

import UIKit

class PostCell: BaseCell {
    var feedController: FeedController?
    
    var post: Post? {
        didSet {
            profileImageView.image = UIImage(named: post?.user?.picture ?? "default")
            
            /* set details label attributes */
            let attributedText = NSMutableAttributedString(string: "\(post?.user?.name ?? "Unknown")\n", attributes: [
                NSAttributedString.Key.font: UIFont(name: "GothamRounded-Medium", size: 18)!,
                NSAttributedString.Key.foregroundColor: UIColor.black
            ])
            
            attributedText.append(NSAttributedString(string: "0m", attributes: [
                NSAttributedString.Key.font: UIFont(name: "GothamRounded-Book", size: 14)!,
                NSAttributedString.Key.foregroundColor: UIColor(r: 201, g: 205, b: 209)
            ]))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            
            attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
            
            detailsLabel.attributedText = attributedText
            
            if post?.commentsCount ?? 0 > 0 {
                let purple = UIColor(r: 169, g: 86, b: 205)
                commentButton.setTitleColor(purple, for: .normal)
                commentButton.tintColor = purple
            } else {
                let grey = UIColor(r: 220, g: 220, b: 220)
                commentButton.setTitleColor(grey, for: .normal)
                commentButton.tintColor = grey
            }
            
            commentButton.setTitle(post?.commentsCount?.description ?? "0", for: .normal)
            
            statusTextView.text = post?.text
            
            // hide the image if there is no photo linked
            if post?.mediaType == MediaType.none {
                mediaImageView.isHidden = true
            }
            
            if let media = post?.media {
                mediaImageView.loadImageUsingCache(urlString: media)
            }
        }
    }
    
    private let containerView = UIView()
    
    private let profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        imageView.makeCorner(withRadius: 25)
        return imageView
    }()
    
    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    private let questionLabel: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "question")!.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor(r: 0, g: 132, b: 255)
        return imageView
    }()
    
    private let menuImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "menu_post")!.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .black
        return imageView
    }()
    
    private let statusTextView : UITextView = {
        let textView = UITextView()
        textView.text = "This is a test!"
        textView.font = UIFont(name: "GothamRounded-Book", size: 16)
        textView.backgroundColor = .clear
        textView.textColor = .black
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.isSelectable = false
        textView.isUserInteractionEnabled = false
        return textView
    }()
    
    private lazy var mediaImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cesar")
        imageView.backgroundColor = .black
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePhotoTap)))
        return imageView
    }()
    
    private let reactionView = UIView()
    
    static func bottomButton(text: String, imageName: String, color: UIColor) -> UIButton {
        let button = UIButton()
        button.setTitle(text, for: .normal)
        button.setTitleColor(color, for: .normal)
        let image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        button.contentMode = .scaleAspectFit
        button.setImage(image, for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamRounded-Medium", size: 14)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        //button.addTarget(self, action: #selector(handleComment(_:)), for: .touchUpInside)
        return button
    }
    
    private let commentButton = PostCell.bottomButton(text: "0", imageName: "comment", color: UIColor(r: 220, g: 220, b: 220))
    private let shareButton = PostCell.bottomButton(text: "0", imageName: "share", color: UIColor(r: 0, g: 132, b: 255))
    
    private let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.05)
        view.isHidden = true
        return view
    }()
    
    @objc func handleComment(_ sender: UIButton) {
        print("Show comments")
    }
    
    override func setupViews() {
        containerView.frame = frame
        
        // set the shadow of the view's layer
        containerView.layer.backgroundColor = UIColor.clear.cgColor
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowRadius = 4.0
        
        makeCorner(withRadius: 10.0)
        backgroundColor = UIColor.white
        
        addSubview(containerView)
        addSubview(profileImageView)
        addSubview(detailsLabel)
        addSubview(menuImageView)
        addSubview(statusTextView)
        addSubview(mediaImageView)
        addSubview(reactionView)
        reactionView.addSubview(shareButton)
        reactionView.addSubview(commentButton)
        addSubview(dividerLineView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: containerView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: containerView)
        
        addConstraintsWithFormat(format: "H:|-8-[v0(50)]-8-[v1]-[v2]-16-|", views: profileImageView, detailsLabel, menuImageView)
        
        addConstraintsWithFormat(format: "H:|-4-[v0]-4-|", views: statusTextView)
        
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: mediaImageView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: dividerLineView)
        
        addConstraintsWithFormat(format: "V:|-12-[v0]", views: detailsLabel)
        
        addConstraintsWithFormat(format: "V:|-18-[v0]", views: menuImageView)
        
        // 8 + 50 + 4 + ? + 4 + (200?) + 8 + 30 + 8 + 1
        addConstraintsWithFormat(format: "V:|-8-[v0(50)]-4-[v1]-4-[v2]-8-[v3(30)]-8-[v4(1)]|", views: profileImageView, statusTextView, mediaImageView, reactionView, dividerLineView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: reactionView)
        
        reactionView.addConstraintsWithFormat(format: "V:|[v0]|", views: shareButton)
        reactionView.addConstraintsWithFormat(format: "V:|[v0]|", views: commentButton)
        reactionView.addConstraintsWithFormat(format: "H:|-12-[v0(40)]-[v1(40)]-12-|", views: shareButton, commentButton)
    }
    
    @objc func handlePhotoTap() {
        feedController?.animateImageView(statusImageView: mediaImageView)
    }
}
