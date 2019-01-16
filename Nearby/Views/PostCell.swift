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
                NSAttributedString.Key.font: UIFont(name: "GothamRounded-Medium", size: 18)!
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
                mediaView.isHidden = true
            }
            
            if let media = post?.media {
                mediaImageView.loadImageUsingCache(urlString: media)
            }
        }
    }
    
    let profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        imageView.makeCorner(withRadius: 25)
        return imageView
    }()
    
    let detailsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    let menuImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "menu_post")!.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .black
        return imageView
    }()
    
    let statusTextView : UITextView = {
        let textView = UITextView()
        textView.text = "This is a test!"
        textView.font = UIFont(name: "GothamRounded-Book", size: 16)
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.isSelectable = false
        return textView
    }()
    
    let mediaView : UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        view.clipsToBounds = false
        view.layer.backgroundColor = UIColor.clear.cgColor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 5.0
        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: 16).cgPath
        return view
    }()
    
    lazy var mediaImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cesar")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePhotoTap)))
        return imageView
    }()
    
    let containerView = UIView()
    
    let commentButton = PostCell.bottomButton(text: "0", imageName: "comment", color: UIColor(r: 220, g: 220, b: 220))
    let shareButton = PostCell.bottomButton(text: "0", imageName: "share", color: UIColor(r: 0, g: 132, b: 255))
    
    static func bottomButton(text: String, imageName: String, color: UIColor) -> UIButton {
        let button = UIButton()
        button.setTitle(text, for: .normal)
        button.setTitleColor(color, for: .normal)
        let image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        //button.contentMode = .scaleAspectFit
        button.setImage(image, for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamRounded-Medium", size: 14)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        //button.addTarget(self, action: #selector(handleComment(_:)), for: .touchUpInside)
        return button
    }
    
    @objc func handleComment(_ sender: UIButton) {
        print("Show comments")
    }
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.05)
        return view
    }()
    
    override func setupViews() {
        addSubview(profileImageView)
        addSubview(detailsLabel)
        addSubview(menuImageView)
        addSubview(statusTextView)
        addSubview(mediaView)
        mediaImageView.frame = mediaView.bounds
        mediaView.addSubview(mediaImageView)
        addSubview(containerView)
        containerView.addSubview(shareButton)
        containerView.addSubview(commentButton)
        addSubview(dividerLineView)
        
        addConstraintsWithFormat(format: "H:|-8-[v0(50)]-8-[v1]|", views: profileImageView, detailsLabel)
        
        addConstraintsWithFormat(format: "H:|-4-[v0]-4-|", views: statusTextView)
        
        addConstraintsWithFormat(format: "H:|-12-[v0(200)]-12-|", views: mediaView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: dividerLineView)
        
        addConstraintsWithFormat(format: "V:|-12-[v0]", views: detailsLabel)
        
        // 8 + 50 + 4 + ? + 4 + (200?) + 8 + 30 + 8 + 1
        addConstraintsWithFormat(format: "V:|-8-[v0(50)]-4-[v1]-4-[v2]-8-[v3(30)]-8-[v4(1)]|", views: profileImageView, statusTextView, mediaView, containerView, dividerLineView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: containerView)
        
        addConstraintsWithFormat(format: "V:|[v0]|", views: shareButton)
        addConstraintsWithFormat(format: "V:|[v0]|", views: commentButton)
        
        addConstraintsWithFormat(format: "H:|-12-[v0(40)]-[v1(40)]-12-|", views: shareButton, commentButton)
        
        mediaView.addConstraintsWithFormat(format: "H:|[v0]|", views: mediaImageView)
        mediaView.addConstraintsWithFormat(format: "V:|[v0]|", views: mediaImageView)
    }
    
    @objc func handlePhotoTap() {
        feedController?.animateImageView(statusImageView: mediaImageView)
    }
}
