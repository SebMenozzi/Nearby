//
//  FeedViewController.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 15/01/2019.
//  Copyright © 2019 Sebastien Menozzi. All rights reserved.
//

import Foundation
import UIKit

class FeedController: UICollectionViewController {
    
    private let cellId = "cellId"
    
    let blackBackgroundView = UIView()
    let zoomImageView = UIImageView()
    var startingFrame : CGRect?
    
    deinit {
        // unlock the slide menu
        isMenuLocked(locked: false)
    }
    
    var statusImageView: UIImageView?
    
    var feed: Feed? {
        didSet {
            navigationItem.title = feed?.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        collectionView?.alwaysBounceVertical = true // enable vertical scroll
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(PostCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView?.keyboardDismissMode = .interactive
        
        setupNavigationItems()
        
        // lock the slide menu
        isMenuLocked(locked: true)
    }
    
    func animateImageView(statusImageView: UIImageView) {
        self.statusImageView = statusImageView
        self.statusImageView?.isHidden = true
        
        // to get the absolute coordinates
        startingFrame = statusImageView.superview?.convert(statusImageView.frame, to: nil)
        
        if let mainWindow = UIApplication.shared.keyWindow {
            blackBackgroundView.frame = mainWindow.frame
            blackBackgroundView.backgroundColor = .black
            blackBackgroundView.alpha = 0
            mainWindow.addSubview(blackBackgroundView)
            
            zoomImageView.backgroundColor = UIColor.red
            zoomImageView.frame = startingFrame!
            zoomImageView.isUserInteractionEnabled = true
            zoomImageView.image = statusImageView.image
            zoomImageView.contentMode = .scaleAspectFill
            // reset corner radius
            zoomImageView.layer.cornerRadius = 0
            zoomImageView.layer.masksToBounds = false
            mainWindow.addSubview(zoomImageView)
            
            zoomImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleZoomOut)))
            blackBackgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleZoomOut)))
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                
                self.zoomImageView.frame = CGRect(x: 0, y: 0, width: mainWindow.frame.width, height: self.startingFrame!.height)
                self.zoomImageView.center = mainWindow.center
                
                self.blackBackgroundView.alpha = 1
            }, completion: nil)
        }
    }
    
    @objc func handleZoomOut(tapGesture: UITapGestureRecognizer) {
        if tapGesture.view != nil {
            zoomImageView.makeCorner(withRadius: 16)
            
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                self.zoomImageView.frame = self.startingFrame!
                self.blackBackgroundView.alpha = 0
            }) { (didComplete) in
                self.zoomImageView.removeFromSuperview()
                self.blackBackgroundView.removeFromSuperview()
                self.statusImageView?.isHidden = false
            }
        }
    }
    
    private func setupNavigationItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New Post", style: .plain, target: self, action: #selector(handleNewPost))
    }
    
    @objc func handleNewPost() {
        print("tap")
    }
    
    private func isMenuLocked(locked: Bool) {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingController)?.isMenuLocked = locked
    }
}


extension FeedController : UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = feed?.posts?.count {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let postCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PostCell
        
        postCell.post = feed?.posts?[indexPath.item]
        postCell.feedController = self
        
        return postCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height : CGFloat = 8 + 50 + 8 + 30 + 8 + 1
        
        let post = feed?.posts?[indexPath.item]
        
        if let text = post?.text {
            height += estimateFrameForText(text: text).height
        }
        
        if post?.mediaType == MediaType.photo {
            height += 200 + 4
        }
        
        return CGSize.init(width: view.frame.width, height: height + 16)
    }
    
    private func estimateFrameForText(text: String) -> CGRect {
        let size = CGSize(width: view.frame.width, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
        let attributes = [ NSAttributedString.Key.font: UIFont(name: "GothamRounded-Medium", size: 18)! ]
        return NSString(string: text).boundingRect(
            with: size,
            options: options,
            attributes: attributes,
            context: nil
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
