//
//  PollGameController.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 04/01/2019.
//  Copyright © 2019 Sebastien Menozzi. All rights reserved.
//

import UIKit

class Quiz: NSObject {
    var question: String?
    var users: [User]?
}

class PollGameController: UIViewController {
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let playButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 0, g: 163, b: 253)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamRounded-Medium", size: 14)
        button.setTitle("Play Now", for: .normal)
        //button.addTextSpacing(2.0)
        // border radius
        button.makeCorner(withRadius: 25)
        // shadow
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 2, height: 0)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 8
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handlePlay), for: .touchUpInside)
        button.addTarget(self, action: #selector(handleButtonAnimation(button:)), for: .touchDown)
        return button
    }()
    
    @objc func handlePlay() {
        print("TEST")
    }
    
    @objc func handleButtonAnimation(button: UIButton) {
        button.scale()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(playButton)
        
        view.addConstraintsWithFormat(format: "H:|-20-[v0]-20-|", views: playButton)
        view.addConstraintsWithFormat(format: "V:[v0]-40-|", views: playButton)
    }
}
