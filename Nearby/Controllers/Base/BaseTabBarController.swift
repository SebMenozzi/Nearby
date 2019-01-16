//
//  BaseTabBarController
//  Nearby
//
//  Created by Sebastien Menozzi on 09/12/2018.
//  Copyright © 2018 Sebastien Menozzi. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarDesign()
        
        setupBottomTabBarDesign()
        
        setupViewControllers()
        
        removeTabbarItemsText()
    }
    
    private func setupNavigationBarDesign() {
        let navigation = UINavigationBar.appearance()
        let navigationFont = UIFont(name: "GothamRounded-Medium", size: 22)
        let navigationLargeFont = UIFont(name: "GothamRounded-Bold", size: 34)
        let barButtonItemFont = UIFont(name: "GothamRounded-Medium", size: 18)
        
        navigation.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: navigationFont!
        ]
        
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            navigation.largeTitleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.black,
                NSAttributedString.Key.font: navigationLargeFont!
            ]
        }
        
        UIBarButtonItem.appearance().setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor : UIColor(r: 0, g: 114, b: 255),
            NSAttributedString.Key.font : barButtonItemFont!
            ], for: .normal)
    }
    
    private func setupBottomTabBarDesign() {
        tabBar.layer.cornerRadius = 5
        tabBar.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        tabBar.isTranslucent = false
        tabBar.unselectedItemTintColor = UIColor(r: 201, g: 205, b: 209)
        
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: 1000, height: 0.5)
        topBorder.backgroundColor = UIColor(white: 0.5, alpha: 0.1).cgColor
        
        tabBar.layer.addSublayer(topBorder)
        
        tabBar.clipsToBounds = true
    }
    
    private func createNavController(viewController: UIViewController, title: String, imageName: String, selectedImageName: String) -> UINavigationController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationItem.title = title
        // tab bar
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        navController.tabBarItem.selectedImage = UIImage(named: selectedImageName)
        navController.navigationBar.prefersLargeTitles = true
        // navigation bar
        navController.navigationBar.setValue(true, forKey: "hidesShadow")
        //navController.navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        //navController.navigationBar.shadowImage = UIImage()
        return navController
    }
    
    private func setupViewControllers() {
        let homeController = HomeController(collectionViewLayout: UICollectionViewFlowLayout())
        let directRoomsController = DirectRoomsController(collectionViewLayout: UICollectionViewFlowLayout())
        let searchController = SearchController(collectionViewLayout: UICollectionViewFlowLayout())
        let profileController = ProfileController(collectionViewLayout: ProfileHeaderLayout())
        
        viewControllers = [
            createNavController(viewController: homeController, title: "Home", imageName: "home", selectedImageName: "home_filled"),
            createNavController(viewController: directRoomsController, title: "Friends", imageName: "friends", selectedImageName: "friends_filled"),
            createNavController(viewController: searchController, title: "Search", imageName: "search", selectedImageName: "search_filled"),
            createNavController(viewController: profileController, title: "Profile", imageName: "profile", selectedImageName: "profile_filled")
        ]
    }
    
    private func removeTabbarItemsText() {
        var offset: CGFloat = 6.0
        
        if #available(iOS 11.0, *), traitCollection.horizontalSizeClass == .regular {
            offset = 0.0
        }
        
        if let items = self.tabBar.items {
            for item in items {
                item.title = ""
                item.imageInsets = UIEdgeInsets(top: offset, left: 0, bottom: -offset, right: 0);
            }
        }
    }
    
    private var bounceAnimation: CAKeyframeAnimation = {
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0, 1.1, 0.8, 1.2, 1.0]
        bounceAnimation.duration = TimeInterval(0.3)
        bounceAnimation.calculationMode = CAAnimationCalculationMode.cubic
        return bounceAnimation
    }()
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // find index if the selected tab bar item, then find the corresponding view and get its image, the view position is offset by 1 because the first item is the background (at least in this case)
        guard let idx = tabBar.items?.index(of: item), tabBar.subviews.count > idx + 1, let imageView = tabBar.subviews[idx + 1].subviews.first as? UIImageView else {
            return
        }
        
        imageView.layer.add(bounceAnimation, forKey: nil)
    }
    
}
