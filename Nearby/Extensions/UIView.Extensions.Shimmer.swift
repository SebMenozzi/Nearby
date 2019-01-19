//
//  UIView.Extensions.Shimmer.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 14/01/2019.
//  Copyright © 2019 Sebastien Menozzi. All rights reserved.
//

import Foundation
import UIKit
import Dispatch

protocol Shimmerable {
    func startShimmering(count: Int) -> Void
    func stopShimmering() -> Void
    var lightShimmerColor: UIColor {get set}
    var darkShimmerColor: UIColor {get set}
    var isShimmering: Bool {get}
}

extension UIView: Shimmerable {
    
    private struct UIViewCustomShimmerProperties {
        static let shimmerKey:String = "shimmer"
        static var lightShimmerColor:CGColor = UIColor.white.withAlphaComponent(0.1).cgColor
        static var darkShimmerColor:CGColor = UIColor.black.withAlphaComponent(1).cgColor
        static var isShimmering:Bool = false
        static var gradient:CAGradientLayer = CAGradientLayer()
        static var animation:CABasicAnimation = CABasicAnimation(keyPath: "locations")
    }
    
    var lightShimmerColor: UIColor {
        get {
            return UIColor(cgColor: UIViewCustomShimmerProperties.lightShimmerColor)
        }
        set {
            UIViewCustomShimmerProperties.lightShimmerColor = newValue.cgColor
        }
    }
    
    var darkShimmerColor: UIColor {
        get {
            return UIColor(cgColor: UIViewCustomShimmerProperties.darkShimmerColor)
        }
        set {
            UIViewCustomShimmerProperties.darkShimmerColor = newValue.cgColor
        }
    }
    
    var isShimmering: Bool {
        get {
            return UIViewCustomShimmerProperties.isShimmering
        }
    }
    
    func stopShimmering() {
        guard UIViewCustomShimmerProperties.isShimmering else {return}
        self.layer.mask?.removeAnimation(forKey: UIViewCustomShimmerProperties.shimmerKey)
        self.layer.mask = nil
        UIViewCustomShimmerProperties.isShimmering = false
        self.layer.setNeedsDisplay()
    }
    
    func startShimmering(count: Int = 3) {
        guard !UIViewCustomShimmerProperties.isShimmering else {return}
        
        /*
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            self.stopShimmering()
        })
        */
        
        UIViewCustomShimmerProperties.isShimmering = true
        
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIViewCustomShimmerProperties.darkShimmerColor,
            UIViewCustomShimmerProperties.lightShimmerColor,
            UIViewCustomShimmerProperties.darkShimmerColor
        ]
        gradient.frame = CGRect(
            x: CGFloat(-2 * self.bounds.size.width),
            y: CGFloat(0.0),
            width: CGFloat(4*self.bounds.size.width),
            height: CGFloat(self.bounds.size.height)
        )
        gradient.startPoint = CGPoint(x: Double(0.0), y: Double(0.5));
        gradient.endPoint = CGPoint(x: Double(1.0), y: Double(0.625));
        gradient.locations = [0.4, 0.5, 0.6];
        self.layer.mask = gradient
        
        let shimmer = CABasicAnimation(keyPath: "locations")
        shimmer.fromValue = [0.0, 0.12, 0.3]
        shimmer.toValue = [0.6, 0.86, 1.0]
        shimmer.duration = 1.0
        shimmer.fillMode = CAMediaTimingFillMode.forwards
        shimmer.isRemovedOnCompletion = false
        
        let group = CAAnimationGroup()
        group.animations = [shimmer]
        group.duration = 5
        group.repeatCount = (count > 0) ? Float(count) : .infinity
        gradient.add(group, forKey: UIViewCustomShimmerProperties.shimmerKey)
        
        //CATransaction.commit()
    }
    
}
