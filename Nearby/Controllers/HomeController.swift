//
//  HomeViewController.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 12/12/2018.
//  Copyright © 2018 Sebastien Menozzi. All rights reserved.
//

import UIKit

class HomeController : UICollectionViewController, UIGestureRecognizerDelegate {
    
    let cellId = "cellId"
    let headerId = "header"
    
    lazy var menuCategoryBar: MenuCategoryBar = {
        let menu = MenuCategoryBar()
        menu.homeController = self
        return menu
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
        
        setupCollectionView()
        
        setupMenuCategoryBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setupCollectionView() {
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.contentInset = UIEdgeInsets(top: 170, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 200, left: 0, bottom: 0, right: 0)
        collectionView?.backgroundColor = UIColor(white: 0, alpha: 0.8)
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.isPagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
    }
    
    private func setupMenuCategoryBar() {
        view.addSubview(menuCategoryBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuCategoryBar)
        view.addConstraintsWithFormat(format: "V:|-15-[v0(45)]", views: menuCategoryBar)
        // select the first feed item
        menuCategoryBar.collectionView.selectItem(at: NSIndexPath(row: 0, section: 0) as IndexPath, animated: false, scrollPosition: .left)
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = NSIndexPath(item: menuIndex, section: 0)
        collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: true)
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let indexPath = NSIndexPath(item: Int(targetContentOffset.pointee.x / view.frame.width), section: 0)
        menuCategoryBar.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: .left)
    }
    
    private func setupBackground() {
        view.backgroundColor = UIColor(r: 109, g: 80, b: 240)
    
        let layerGradient = CAGradientLayer()
        layerGradient.colors = [UIColor(white: 0, alpha: 0).cgColor, UIColor(white: 0, alpha: 0.6).cgColor]
        layerGradient.startPoint = CGPoint(x: 0, y: 0.8)
        layerGradient.endPoint = CGPoint(x: 0, y: 1)
        layerGradient.frame = view.frame
        layerGradient.masksToBounds = true
        //layerGradient.shouldRasterize = true
        view?.layer.addSublayer(layerGradient)
    }
    
    @objc func handleOpen() {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingController)?.openMenu()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
}

extension HomeController : UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = menuCategoryBar.categories?.count {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCell
        cell.homeController = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
}
