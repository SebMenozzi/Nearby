//
//  UIButton.Extensions.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 18/01/2019.
//  Copyright © 2019 Sebastien Menozzi. All rights reserved.
//

import UIKit

extension UIButton {
    
    func addTextSpacing(_ letterSpacing: CGFloat) {
        let attributedString = NSMutableAttributedString(string: (self.titleLabel?.text)!)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: letterSpacing, range: NSRange(location: 0, length: (self.titleLabel?.text!.count)!))
        self.setAttributedTitle(attributedString, for: .normal)
    }

}
