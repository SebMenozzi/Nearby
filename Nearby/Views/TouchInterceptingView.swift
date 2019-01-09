//
//  TouchInterceptingView.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 11/12/2018.
//  Copyright © 2018 Sebastien Menozzi. All rights reserved.
//

import UIKit

protocol TouchInterceptingViewDelegate: class {
    func touchIntercepted(point: CGPoint)
}

class TouchInterceptingView: UIView {
    
    weak var delegate: TouchInterceptingViewDelegate?
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if event?.type == UIEvent.EventType.touches {
            delegate?.touchIntercepted(point: point)
        }
        return super.hitTest(point, with: event)
    }
}
