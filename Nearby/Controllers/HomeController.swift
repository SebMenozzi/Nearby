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
    
    var popularRooms: [Room]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.alwaysBounceVertical = true
        collectionView.register(RoomCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(HeaderSection.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        setupNavigationItems()
        
        checkIfUserIsLoggedIn()
        
        setupData()
    }
    
    private func setupNavigationItems() {
        navigationItem.title = "Home"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(handleOpen))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.black
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New Room", style: .plain, target: self, action: #selector(handleNewRoom))
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
        
        self.present(LoginViewController(), animated: !withoutAnimation, completion: nil)
    }
}

extension HomeController : UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = popularRooms?.count {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! RoomCell
        
        if let room = popularRooms?[indexPath.item] {
            cell.room = room
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: view.frame.width, height: 65)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        let controller = ChatViewController(collectionViewLayout: layout)
        let room = popularRooms?[indexPath.item]
        controller.room = room
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 160)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! HeaderSection
        header.frame.size.height = 160
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

class HeaderSection: UICollectionReusableView {
    let containerView = UIView()
    let topView = UIView()
    let bottomView = UIView()
    
    let cityLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 25)
        label.text = "Reims"
        return label
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "602 rooms 🎉"
        return label
    }()
    
    let viewAllLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "View all"
        return label
    }()
    
    let weatherIconLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.font = UIFont(name: "WeatherIcons-Regular", size: 25)
        label.text = "\u{f00d}"
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "Popular Rooms 🔥"
        return label
    }()
    
    private var shadowLayer: CAShapeLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(gesture:)))
        containerView.addGestureRecognizer(tapGesture)
        
        containerView.frame = frame
        
        // set the shadow of the view's layer
        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 5.0

        // set the gradient of the containerView's layer
        containerView.setGradientBackground(
            startColor: UIColor(r: 0, g: 114, b: 255),
            //endColor: UIColor(r: 0, g: 198, b: 255)
            endColor: UIColor(r: 207, g: 162, b: 250),
            startpoint: CGPoint(x: 0.0, y: 0.5),
            endPoint: CGPoint(x: 1.0, y: 0.5)
        )
        
        // set the cornerRadius of the containerView's layer
        containerView.makeCorner(withRadius: 10.0)
        
        addSubview(containerView)
        addSubview(titleLabel)
        
        addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: containerView)
        addConstraintsWithFormat(format: "V:|-10-[v0]-20-[v1]-10-|", views: containerView, titleLabel)
        addConstraintsWithFormat(format: "H:|-20-[v0]-10-|", views: titleLabel)
        
        containerView.addSubview(topView)
        containerView.addSubview(bottomView)
        
        addConstraintsWithFormat(format: "H:|-15-[v0]-15-|", views: topView)
        addConstraintsWithFormat(format: "H:|-15-[v0]-15-|", views: bottomView)
        addConstraintsWithFormat(format: "V:|-20-[v0]-10-[v1]-20-|", views: topView, bottomView)
        
        topView.addSubview(cityLabel)
        topView.addSubview(weatherIconLabel)
        
        addConstraintsWithFormat(format: "H:|[v0]-[v1]|", views: cityLabel, weatherIconLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: cityLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: weatherIconLabel)
        
        bottomView.addSubview(infoLabel)
        bottomView.addSubview(viewAllLabel)
        
        addConstraintsWithFormat(format: "H:|[v0]-10-[v1]|", views: infoLabel, viewAllLabel) // 10 padding is weird but it works o_o
        addConstraintsWithFormat(format: "V:|[v0]|", views: infoLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: viewAllLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleTap(gesture: UILongPressGestureRecognizer) {
        print("tap")
    }
}

class RoomCell: BaseCell {
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.1) {
                let scale: CGFloat = 0.95
                self.transform = self.isHighlighted ? CGAffineTransform(scaleX: scale, y: scale) : .identity
            }
        }
    }
    
    var room: Room? {
        didSet {
            nameLabel.text = room?.name
            
            if (room?.type == RoomType.public_room) {
                signImageView.image = UIImage(named: "hashtag")!.withRenderingMode(.alwaysTemplate)
            }
            else if (room?.type == RoomType.private_room) {
                signImageView.image = UIImage(named: "lock")!.withRenderingMode(.alwaysTemplate)
            }
            else if (room?.type == RoomType.personal_room) {
                signImageView.image = UIImage(named: "at")!.withRenderingMode(.alwaysTemplate)
            }
            
            connectedLabel.text = room?.numberConnected?.description
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
