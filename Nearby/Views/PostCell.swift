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
            
            let attributedText = NSMutableAttributedString(string: "\(post?.user?.name ?? "Unknown") ", attributes: [
                NSAttributedString.Key.font: UIFont(name: "GothamRounded-Medium", size: 18)!,
                NSAttributedString.Key.foregroundColor: UIColor.white
            ])
            
            attributedText.append(NSAttributedString(string: "\(post?.user?.username ?? "unknown")\n", attributes: [
                NSAttributedString.Key.font: UIFont(name: "GothamRounded-Medium", size: 16)!,
                NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.6)
            ]))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 8
            attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
            
            attributedText.append(NSAttributedString(string: "\(post?.text ?? "This is a test!")", attributes: [
                NSAttributedString.Key.font: UIFont(name: "GothamRounded-Book", size: 16)!,
                NSAttributedString.Key.foregroundColor: UIColor.white
            ]))
            
            messageTextView.attributedText = attributedText
            
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
            
            // hide the image if there is no photo linked
            if post?.mediaType == MediaType.none {
                mediaImageView.isHidden = true
            }
            
            if let media = post?.media {
                mediaImageView.loadImageUsingCache(urlString: media)
            }
        }
    }
    
    private let profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        imageView.makeCorner(withRadius: 25)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let messageTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.textColor = .white
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.isSelectable = false
        textView.isUserInteractionEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let menuImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "menu_post")!.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var mediaImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        imageView.backgroundColor = .black
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePhotoTap)))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
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
    private let repostButton = PostCell.bottomButton(text: "0", imageName: "share", color: UIColor(r: 0, g: 132, b: 255))
    
    private let feedLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.makeCorner(withRadius: 1.25)
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        
        // set the shadow of the view's layer
        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 4.0
        
        backgroundColor = .clear
        
        addSubview(profileImageView)
        addSubview(messageTextView)
        addSubview(menuImageView)
        addSubview(mediaImageView)
        
        setupProfileImageView()
        setupMessageTextView()
        setupMenuImageView()
        setupMediaImageView()
        setupBottomButtons()
    }
    
    private func setupProfileImageView() {
        profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
    }
    
    private func setupMessageTextView() {
        messageTextView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8).isActive = true
        messageTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        messageTextView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        //messageTextView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func setupMediaImageView() {
        mediaImageView.topAnchor.constraint(equalTo: messageTextView.bottomAnchor, constant: 8).isActive = true
        mediaImageView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8).isActive = true
        mediaImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        //mediaImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func setupMenuImageView() {
        menuImageView.topAnchor.constraint(equalTo: topAnchor, constant: 18).isActive = true
        menuImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        menuImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        menuImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func setupBottomButtons() {
        let buttonStackView = UIStackView(arrangedSubviews: [repostButton, commentButton])
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(buttonStackView)
        
        buttonStackView.topAnchor.constraint(equalTo: mediaImageView.bottomAnchor, constant: 8).isActive = true
        buttonStackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        buttonStackView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        buttonStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    @objc func handlePhotoTap() {
        feedController?.animateImageView(statusImageView: mediaImageView)
    }
    
    @objc func handleComment(_ sender: UIButton) {
        print("Show comments")
    }
}
