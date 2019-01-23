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
    private let padding: CGFloat = 10
    
    let blackBackgroundView = UIView()
    let zoomImageView = UIImageView()
    var startingFrame : CGRect?
    
    var statusImageView: UIImageView?
    
    var feed: Feed? {
        didSet {
            navigationItem.title = feed?.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
        
        collectionView?.backgroundColor = UIColor(white: 0, alpha: 0)
        collectionView?.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        collectionView?.alwaysBounceVertical = true // enable vertical scroll
        
        collectionView?.register(PostCell.self, forCellWithReuseIdentifier: cellId)
        
        setupNavigationItems()
        
        // lock the slide menu
        isMenuLocked(locked: true)
    }
    
    private func setupBackground() {
        view.backgroundColor = feed?.color
        
        let layerGradient = CAGradientLayer()
        layerGradient.colors = [UIColor(white: 0, alpha: 0).cgColor, UIColor(white: 0, alpha: 0.6).cgColor]
        layerGradient.startPoint = CGPoint(x: 0, y: 0.8)
        layerGradient.endPoint = CGPoint(x: 0, y: 1)
        layerGradient.frame = view.frame
        //layerGradient.shouldRasterize = true
        view?.layer.addSublayer(layerGradient)
    }
    
    deinit {
        // unlock the slide menu
        isMenuLocked(locked: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationController()
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.barTintColor = feed?.color ?? FeedColor.violet
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func animateImageView(statusImageView: UIImageView) {
        self.statusImageView = statusImageView
        self.statusImageView?.isHidden = true
        
        // to get the absolute coordinates
        startingFrame = statusImageView.superview?.convert(statusImageView.frame, to: nil)
        
        if let mainWindow = UIApplication.shared.keyWindow {
            blackBackgroundView.frame = mainWindow.frame
            blackBackgroundView.backgroundColor = .clear
            mainWindow.addSubview(blackBackgroundView)
            
            zoomImageView.backgroundColor = UIColor.black
            zoomImageView.frame = startingFrame!
            zoomImageView.isUserInteractionEnabled = true
            zoomImageView.image = statusImageView.image
            zoomImageView.contentMode = .scaleAspectFit
            // reset corner radius
            zoomImageView.layer.cornerRadius = 0
            zoomImageView.layer.masksToBounds = false
            blackBackgroundView.addSubview(zoomImageView)
            
            blackBackgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
            blackBackgroundView.addGestureRecognizer(panGestureRecognizer)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                
                self.zoomImageView.frame = CGRect(x: 0, y: 0, width: mainWindow.frame.width, height: mainWindow.frame.height)
                self.zoomImageView.center = mainWindow.center
                
                self.blackBackgroundView.backgroundColor = .black
            }, completion: nil)
        }
    }
    
    private func zoomOut() {
        zoomImageView.makeCorner(withRadius: 16)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.zoomImageView.frame = self.startingFrame!
            self.blackBackgroundView.backgroundColor = .clear
        }) { (didComplete) in
            self.blackBackgroundView.removeFromSuperview()
            self.statusImageView?.isHidden = false
        }
    }
    
    @objc func handleTap(tapGesture: UITapGestureRecognizer) {
        if tapGesture.view != nil {
            zoomOut()
        }
    }
    
    var originalPosition: CGPoint?
    var identity: CGAffineTransform?
    
    @objc func handlePan(panGesture: UIPanGestureRecognizer) {
        
        let translation = panGesture.translation(in: zoomImageView)
        let velocity = panGesture.velocity(in: zoomImageView)
        
        switch panGesture.state {
            case .began:
                originalPosition = zoomImageView.center
                identity = zoomImageView.transform
            case .changed:
                blackBackgroundView.backgroundColor = .clear
                zoomImageView.frame.origin = CGPoint(x: translation.x, y: translation.y)
                /*
                let scale = 1 - abs(translation.y) / zoomImageView.frame.size.height
                print(scale)
                if scale > 0 {
                    zoomImageView.transform = identity!.scaledBy(x: scale, y: scale)
                }
                */
            case .ended, .cancelled:
                if abs(velocity.x) >= 150 || abs(velocity.y) >= 150 {
                    zoomOut()
                } else {
                    UIView.animate(withDuration: 0.3, animations: {
                        self.blackBackgroundView.backgroundColor = .black
                        self.zoomImageView.center = self.originalPosition!
                        self.zoomImageView.transform = self.identity!
                    })
                }
            case .failed, .possible:
                break
        }
    }
    
    private func setupNavigationItems() {
        //let imgBack = UIImage(named: "return")
        
        //navigationController?.navigationBar.backIndicatorImage = imgBack
        //navigationController?.navigationBar.backIndicatorTransitionMaskImage = imgBack
        
        /*
        navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(named: "return"), style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem?.tintColor = UIColor.white
        */
        navigationItem.backBarButtonItem?.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        navigationController?.navigationBar.tintColor = .white
        
        navigationItem.leftItemsSupplementBackButton = true
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        /*
        navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(named: "return"), style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem?.tintColor = UIColor.white
        */
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New Post", style: .plain, target: self, action: #selector(handleNewPost))
    }
    
    @objc func handleNewPost() {
        print("tap")
    }
    
    private func isMenuLocked(locked: Bool) {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingController)?.isMenuLocked = locked
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
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
        
        return CGSize.init(width: view.frame.width - 2 * padding, height: height + 16)
    }
    
    private func estimateFrameForText(text: String) -> CGRect {
        let size = CGSize(width: view.frame.width - 2 * padding, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [ NSAttributedString.Key.font: UIFont(name: "GothamRounded-Book", size: 18)! ]
        return NSString(string: text).boundingRect(
            with: size,
            options: options,
            attributes: attributes,
            context: nil
        )
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        let controller = CommentController(collectionViewLayout: layout)
        let post = feed?.posts?[indexPath.item]
        controller.post = post
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
}
