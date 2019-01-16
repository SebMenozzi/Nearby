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
    
    var feeds: [Feed]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.alwaysBounceVertical = true
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        //collectionView?.register(HomeHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        setupNavigationItems()
        
        checkIfUserIsLoggedIn()
        
        setupData()
    }
    
    private func setupNavigationItems() {
        navigationItem.title = "Home"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(handleOpen))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.black
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New Feed", style: .plain, target: self, action: #selector(handleNewRoom))
    }
    
    @objc func handleNewRoom() {
        let newRoomController = NewRoomController()
        let navController = UINavigationController(rootViewController: newRoomController)
        present(navController, animated: true, completion: nil)
    }
    
    @objc func handlePlay() {
        let newPollGameController = PollGameController()
        let navController = UINavigationController(rootViewController: newPollGameController)
        present(navController, animated: true, completion: nil)
    }
    
    @objc func handleOpen() {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingController)?.openMenu()
    }
    
    func checkIfUserIsLoggedIn() {
        if !AuthService.instance.isLoggedIn {
            handleLogout(withoutAnimation: true)
        }
    }
    
    @objc func handleLogout(withoutAnimation: Bool = false) {
        AuthService.instance.logout()
        
        self.present(LoginViewController2(), animated: !withoutAnimation, completion: nil)
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
        return 0
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
            nameLabel.text = feed?.name
            
            if (feed?.type == FeedType.public_feed) {
                signImageView.image = UIImage(named: "hashtag")!.withRenderingMode(.alwaysTemplate)
            }
            else if (feed?.type == FeedType.private_feed) {
                signImageView.image = UIImage(named: "lock")!.withRenderingMode(.alwaysTemplate)
            }
            else if (feed?.type == FeedType.personal_feed) {
                signImageView.image = UIImage(named: "at")!.withRenderingMode(.alwaysTemplate)
            }
            
            connectedLabel.text = feed?.numberConnected?.description
        }
    }
    
    let signImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "hashtag")!.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.init(r: 220, g: 220, b: 220)
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Unknown"
        label.font = UIFont(name: "GothamRounded-Medium", size: 18)
        return label
    }()
    
    let connectedLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(r: 24, g: 218, b: 59)
        label.font = UIFont(name: "GothamRounded-Medium", size: 12)
        label.text = "102"
        return label
    }()
    
    let connectedSign: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 24, g: 218, b: 59)
        view.makeCorner(withRadius: 4)
        return view
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.05)
        return view
    }()
    
    override func setupViews() {
        addSubview(signImageView)
        addSubview(nameLabel)
        addSubview(connectedLabel)
        addSubview(connectedSign)
        addSubview(dividerLineView)
        
        addConstraintsWithFormat(format: "H:|-20-[v0]-20-|", views: dividerLineView)
        addConstraintsWithFormat(format: "V:[v0(1)]|", views: dividerLineView)
        
        addConstraintsWithFormat(format: "H:|-20-[v0(20)]-20-[v1]-[v2]-5-[v3(8)]-30-|", views: signImageView, nameLabel, connectedLabel, connectedSign)
        addConstraintsWithFormat(format: "V:[v0(20)]", views: signImageView)
        addConstraintsWithFormat(format: "V:[v0]", views: nameLabel)
        addConstraintsWithFormat(format: "V:[v0]", views: connectedLabel)
        addConstraintsWithFormat(format: "V:[v0(8)]", views: connectedSign)
        
        // centering vertically the views
        signImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        connectedLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        connectedSign.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
