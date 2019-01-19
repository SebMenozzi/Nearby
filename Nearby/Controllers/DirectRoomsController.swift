//
//  DirectRoomsController.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 07/12/2018.
//  Copyright © 2018 Sebastien Menozzi. All rights reserved.
//

import UIKit

class DirectRoomsController: UICollectionViewController {
    
    /*
    private let cellId = "cellId"
    
    var directRooms: [Room]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.white // put the background in white
        collectionView.alwaysBounceVertical = true // enable vertical scroll
        collectionView.register(DirectRoomCell.self, forCellWithReuseIdentifier: cellId)
        
        setupNavigationItems()
        
        setupData()
    }
    
    private func setupNavigationItems() {
        navigationItem.title = "Friends"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(handleOpen))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.black
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Friends", style: .plain, target: self, action: #selector(handleAddFriends))
    }
    
    @objc func handleAddFriends() {
        print("Add Friends")
    }
    
    @objc func handleOpen() {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingController)?.openMenu()
    }
}

extension DirectRoomsController : UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = directRooms?.count {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DirectRoomCell
        
        if let room = directRooms?[indexPath.item] {
            cell.room = room
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // each cell take screen width and 100px height
        return CGSize.init(width: view.frame.width, height: 80)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        let controller = ChatViewController(collectionViewLayout: layout)
        let room = directRooms?[indexPath.item]
        controller.room = room
        navigationController?.pushViewController(controller, animated: true)
    }
}

class DirectRoomCell: BaseCell {
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.black : UIColor.white
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            timeLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            messageLabel.textColor = isHighlighted ? UIColor.white : UIColor.darkGray
        }
    }
    
    var room: Room? {
        didSet {
            let length = room?.messages?.count

            if let lastMessage = room?.messages?[length! - 1] {
                
                nameLabel.text = lastMessage.user?.username 
                
                if let picture = lastMessage.user?.picture {
                    profileImageView.loadImageUsingCache(urlString: picture)
                    hasReadImageView.loadImageUsingCache(urlString: picture)
                }
                
                messageLabel.text = lastMessage.text
                
                if let date =  lastMessage.date {
                    let dateFormatter = DateFormatter()
                    dateFormatter.locale = Locale(identifier: "en_US")
                    
                    dateFormatter.dateFormat = "h:mm a"
                    
                    let elapsedTimeInSeconds = Date().timeIntervalSince(date)
                    let secondInDays: TimeInterval = 60 * 60 * 24
                    
                    // more or equal than a week
                    if elapsedTimeInSeconds > 7 * secondInDays {
                        dateFormatter.dateFormat = "MMMM d"
                    }
                        // more or equal than a day
                    else if elapsedTimeInSeconds > secondInDays {
                        dateFormatter.dateFormat = "EEE"
                    }
                    
                    timeLabel.text = dateFormatter.string(from: date)
                }
            }
        }
    }
    
    let profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 30
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "default")
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sebastien Menozzi"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Your friend's message and something else..."
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "12:05 pm"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    
    let hasReadImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "default")
        return imageView
    }()
    
    override func setupViews() {
        addSubview(profileImageView)
        
        setupContainerView()
        
        profileImageView.image = UIImage(named: "seb")
        hasReadImageView.image = UIImage(named: "seb")
        
        addConstraintsWithFormat(format: "H:|-12-[v0(60)]", views: profileImageView)
        addConstraintsWithFormat(format: "V:[v0(60)]", views: profileImageView)
        
        // centering the image profile
        addConstraint(NSLayoutConstraint(item: profileImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    private func setupContainerView() {
        let containerView = UIView()
        addSubview(containerView)
        
        addConstraintsWithFormat(format: "H:|-90-[v0]|", views: containerView)
        addConstraintsWithFormat(format: "V:[v0(50)]", views: containerView)
        
        // centering the container
        addConstraint(NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        containerView.addSubview(nameLabel)
        containerView.addSubview(messageLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(hasReadImageView)
        
        containerView.addConstraintsWithFormat(format: "H:|[v0][v1(120)]-12-|", views: nameLabel, timeLabel)
        containerView.addConstraintsWithFormat(format: "V:|[v0][v1(24)]|", views: nameLabel, messageLabel)
        
        containerView.addConstraintsWithFormat(format: "H:|[v0]-8-[v1(20)]-12-|", views: messageLabel, hasReadImageView)
        
        containerView.addConstraintsWithFormat(format: "V:|[v0(24)]", views: timeLabel)
        
        containerView.addConstraintsWithFormat(format: "V:[v0(20)]|", views: hasReadImageView)
    }
 */
}
