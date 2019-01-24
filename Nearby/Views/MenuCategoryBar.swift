//
//  MenuCategoryBar.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 23/01/2019.
//  Copyright © 2019 Sebastien Menozzi. All rights reserved.
//

import UIKit

class MenuCategoryBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var categories: [MenuCategory]?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8.0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let cellId = "cellId"
    
    var homeController: HomeController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 5, right: 0)
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(MenuCategoryCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        setupData()
    }
    
    private func setupData() {
        let my_channel = MenuCategory()
        my_channel.text = "My Channels"
        
        let popular = MenuCategory()
        popular.text = "Popular 🔥"
        
        let celebrities = MenuCategory()
        celebrities.text = "Celibrities ✨"
        
        let football = MenuCategory()
        football.text = "Football ⚽️"
        
        categories = [my_channel, popular, celebrities, football]
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = categories?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCategoryCell
        
        if let category = categories?[indexPath.item] {
            cell.category = category
        }
        
        return cell
    }
    
    private func estimateFrameForText(text: String) -> CGRect {
        let size = CGSize(width: 1000, height: 35)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [ NSAttributedString.Key.font: UIFont(name: "GothamRounded-Medium", size: 14)! ]
        return NSString(string: text).boundingRect(
            with: size,
            options: options,
            attributes: attributes,
            context: nil
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width : CGFloat = 30
        
        let category = categories?[indexPath.item]
        
        if let text = category?.text {
            width += estimateFrameForText(text: text).width + 1
        }
        return CGSize(width: width, height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        homeController?.scrollToMenuIndex(menuIndex: indexPath.item)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class MenuCategoryCell: BaseCell {
    
    var category: MenuCategory? {
        didSet {
            categoryLabel.text = category?.text
        }
    }
    
    let categoryView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.4)
        view.makeCorner(withRadius: 17.5)
        return view
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(white: 1, alpha: 0.6)
        label.text = "My Channel"
        label.font =  UIFont(name: "GothamRounded-Medium", size: 14)
        return label
    }()
    
    override var isHighlighted: Bool {
        didSet {
            categoryView.backgroundColor = isHighlighted ? UIColor(r: 139, g: 74, b: 206) : UIColor(white: 0, alpha: 0.4)
            categoryLabel.textColor = isHighlighted ? .white : UIColor(white: 1, alpha: 0.6)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            categoryView.backgroundColor = isSelected ? UIColor(r: 139, g: 74, b: 206) : UIColor(white: 0, alpha: 0.4)
            categoryLabel.textColor = isSelected ? .white : UIColor(white: 1, alpha: 0.6)
        }
    }
    
    override func setupViews() {
        addSubview(categoryView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: categoryView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: categoryView)
        
        categoryView.addSubview(categoryLabel)
        categoryView.addConstraintsWithFormat(format: "H:|-15-[v0]-15-|", views: categoryLabel)
        categoryView.addConstraintsWithFormat(format: "V:|-10-[v0]-10-|", views: categoryLabel)
    }
}
