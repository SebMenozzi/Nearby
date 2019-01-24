//
//  ChannelCell.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 23/01/2019.
//  Copyright © 2019 Sebastien Menozzi. All rights reserved.
//

import UIKit

class ChannelCell: BaseCell {
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.1) {
                let scale: CGFloat = 0.95
                self.transform = self.isHighlighted ? CGAffineTransform(scaleX: scale, y: scale) : .identity
            }
        }
    }
    
    var feed: Feed? {
        didSet {
            /* set details label attributes */
            let attributedText = NSMutableAttributedString(string: "\(feed?.name ?? "Unknown")\n", attributes: [
                NSAttributedString.Key.font: UIFont(name: "GothamRounded-Book", size: 18)!,
                NSAttributedString.Key.foregroundColor: UIColor.white
            ])
            
            attributedText.append(NSAttributedString(string: "\(feed?.identifier ?? "#unknown")", attributes: [
                NSAttributedString.Key.font: UIFont(name: "GothamRounded-Book", size: 14)!,
                NSAttributedString.Key.foregroundColor: UIColor(white: 1, alpha: 0.8)
            ]))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            
            attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
            
            detailsLabel.attributedText = attributedText
            
            emojiLabel.text = feed?.emoji
            
            if let color = feed?.color {
                emojiContainerView.backgroundColor = color
            }
        }
    }
    
    private let emojiContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = FeedColor.violet
        view.makeCorner(withRadius: 28)
        return view
    }()
    
    private let emojiLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    override func setupViews() {
        addSubview(emojiContainerView)
        emojiContainerView.addSubview(emojiLabel)
        addSubview(detailsLabel)
        
        addConstraintsWithFormat(format: "H:|-12-[v0(56)]-12-[v1]|", views: emojiContainerView, detailsLabel)
        
        addConstraintsWithFormat(format: "V:|-12-[v0]", views: detailsLabel)
        
        // 8 + 50 + 4 + ? + 4 + (200?) + 8 + 30 + 8 + 1
        addConstraintsWithFormat(format: "V:[v0(56)]", views: emojiContainerView)
        
        emojiContainerView.addConstraintsWithFormat(format: "H:|[v0]|", views: emojiLabel)
        emojiContainerView.addConstraintsWithFormat(format: "V:|[v0]|", views: emojiLabel)
    }
}
