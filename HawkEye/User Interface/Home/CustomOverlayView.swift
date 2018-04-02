//
//  CustomOverlayView.swift
//  HawkEye
//
//  Created by PointerFLY on 02/04/2018.
//  Copyright © 2018 PointerFLY. All rights reserved.
//

import UIKit
import Koloda

class CustomOverlayView: OverlayView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 8.0
        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var overlayState: SwipeResultDirection?  {
        didSet {
            switch overlayState {
            case .left? :
                self.backgroundColor = UIColor(hex: "dd5452")
            case .right? :
                self.backgroundColor = UIColor(hex: "53c84f")
            default:
                self.backgroundColor = UIColor.white.alpha(0)
            }
            
        }
    }
    
}

