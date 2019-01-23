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
    
    let menuCategoryBar: MenuCategoryBar = {
        let menu = MenuCategoryBar()
        return menu
    }()
    
    var feeds: [Feed]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
        
        collectionView?.contentInset = UIEdgeInsets(top: 55, left: 0, bottom: 10, right: 0)
        collectionView?.backgroundColor = UIColor(white: 0, alpha: 0.8)
        collectionView?.alwaysBounceVertical = true
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        //collectionView?.register(HomeHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        //setupNavigationItems()
        
        setupData()
        
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
    
    private func setupMenuCategoryBar() {
        view.addSubview(menuCategoryBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuCategoryBar)
        view.addConstraintsWithFormat(format: "V:|-15-[v0(45)]", views: menuCategoryBar)
    }
    
    private func setupBackground() {
        view.backgroundColor = UIColor(r: 109, g: 80, b: 240)
    
        let layerGradient = CAGradientLayer()
        layerGradient.colors = [UIColor(white: 0, alpha: 0).cgColor, UIColor(white: 0, alpha: 0.6).cgColor]
        layerGradient.startPoint = CGPoint(x: 0, y: 0.8)
        layerGradient.endPoint = CGPoint(x: 0, y: 1)
        layerGradient.frame = view.frame
        //layerGradient.shouldRasterize = true
        view?.layer.addSublayer(layerGradient)
    }
    
    /*
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationController()
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.barTintColor = .clear
        navigationController?.navigationBar.isTranslucent = true
    }
    */
    
    private func setupNavigationItems() {        
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(white: 0, alpha: 0.3)
        button.makeCorner(withRadius: 20)
        button.translatesAutoresizingMaskIntoConstraints = true
        
        button.widthAnchor.constraint(equalToConstant: 110.0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        
        let attributedTitle = NSMutableAttributedString(string: "💎 ", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25)
        ])
        
        attributedTitle.append(NSAttributedString(string: "3,678", attributes: [
            NSAttributedString.Key.font: UIFont(name: "GothamRounded-Book", size: 18)!,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.baselineOffset: 2
        ]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.titleLabel?.numberOfLines = 1
        
        button.sizeToFit()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
        //navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(handleOpen))
        //navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
    }
    
    @objc func handleNewRoom() {
        let newRoomController = NewRoomController()
        let navController = UINavigationController(rootViewController: newRoomController)
        present(navController, animated: true, completion: nil)
    }
    
    @objc func handleOpen() {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingController)?.openMenu()
    }
    
    @objc func handleLogout(withoutAnimation: Bool = false) {
        AuthService.instance.logout()
        
        self.present(LoginController(), animated: !withoutAnimation, completion: nil)
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
}

extension HomeController : UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = feeds?.count {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCell
        
        if let feed = feeds?[indexPath.item] {
            cell.feed = feed
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: view.frame.width, height: 65)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        let controller = FeedController(collectionViewLayout: layout)
        let feed = feeds?[indexPath.item]
        controller.feed = feed
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    /*
    Home Header
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 160)
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! HomeHeader
        header.frame.size.height = 160
        return header
    }
    */
}

class FeedCell: BaseCell {
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
