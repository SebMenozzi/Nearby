//
//  MenuContainerController.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 03/01/2019.
//  Copyright © 2019 Sebastien Menozzi. All rights reserved.
//

import UIKit

class MenuContainerController: UIViewController {
    
    let menuController = MenuController()
    
    let searchContainer = UIView()
    let profileImageView = UIImageView(image: UIImage(named: "seb"))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        let menuView = menuController.view!
        view.addSubview(menuView)
        
        view.addSubview(searchContainer)
        
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.makeCorner(withRadius: 20)
        view.addSubview(profileImageView)
        
        profileImageView.anchor(top: nil, leading: view.leadingAnchor, bottom: searchContainer.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 8, bottom: 22, right: 4), size: .init(width: 38, height: 38))
        
        let searchBar = UISearchBar()
        searchContainer.addSubview(searchBar)
        searchBar.fillSuperview()
        searchBar.searchBarStyle = .prominent
        searchBar.placeholder = "Search..."
        searchBar.barTintColor = .clear
        
        searchBar.anchor(top: nil, leading: profileImageView.trailingAnchor, bottom: searchBar.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 4, right: 0))
        
        let textfieldSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textfieldSearchBar?.textColor = .white
        textfieldSearchBar?.backgroundColor = UIColor(white: 1, alpha: 0.1)
        
        searchContainer.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        searchContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64).isActive = true
        
        menuView.anchor(top: searchContainer.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)

    }
}
