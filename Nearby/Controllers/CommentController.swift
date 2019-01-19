//
//  CommentController.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 15/01/2019.
//  Copyright © 2019 Sebastien Menozzi. All rights reserved.
//


import Foundation
import UIKit

class CommentController: UICollectionViewController {
    
    private let cellId = "cellId"
    
    let modalController = ModalController()
    
    var post: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        collectionView?.alwaysBounceVertical = true // enable vertical scroll
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(CommentCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView?.keyboardDismissMode = .interactive
        
        setupNavigationItems()
    }
    
    private func setupNavigationItems() {
        navigationItem.title = "Comments"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(handleSettings))
    }
    
    @objc func handleSettings() {
        modalController.showModal(startView: view)
    }
}


extension CommentController : UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = post?.comments?.count {
            return count
        }
        return 0
    }
    
    func estimateFrameForText(text: String) -> CGRect {
        let size = CGSize.init(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [ NSAttributedString.Key.font: UIFont(name: "GothamRounded-Book", size: 16)! ]
        return NSString(string: text).boundingRect(
            with: size,
            options: options,
            attributes: attributes,
            context: nil
        )
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CommentCell
        
        cell.comment = post?.comments?[indexPath.item]
        
        if let text = cell.comment?.text {
            
            let estimatedFrame = estimateFrameForText(text: text)
            
            cell.bubbleView.frame = CGRect.init(
                x: 64,
                y: 0,
                width: 8 + (estimatedFrame.width + 16) + 8,
                height: 6 + 20 + (estimatedFrame.height + 6) + 6
            )
            
            cell.nameLabel.frame = CGRect.init(
                x: 64 + 8,
                y: 6,
                width: (estimatedFrame.width + 16),
                height: 20
            )
            
            cell.messageTextView.frame = CGRect.init(
                x: 64 + 4,
                y: 20,
                width: (estimatedFrame.width + 16),
                height: (estimatedFrame.height + 20)
            )
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let comment = post?.comments?[indexPath.item]
        
        if let text = comment?.text {
            let estimatedFrame = estimateFrameForText(text: text)
            
            return CGSize.init(width: view.frame.width, height: estimatedFrame.height + 20)
        }
        
        return CGSize.init(width: view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
}

