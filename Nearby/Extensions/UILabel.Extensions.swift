//
//  UILabel.Extensions.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 18/01/2019.
//  Copyright © 2019 Sebastien Menozzi. All rights reserved.
//

import UIKit

extension UILabel {
    func addTextSpacing(_ letterSpacing: CGFloat) {
        if let labelText = text, labelText.count > 0 {
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(NSAttributedString.Key.kern, value: letterSpacing, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}
