//
//  UITextField+Extension.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 26/11/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    func setBottomBorder(with color: UIColor, and height: CGFloat) {
        let lineView = UIView.init(frame: CGRect(origin: self.bottomLeft(), size: CGSize(width: self.frame.width, height: height)))
        lineView.backgroundColor = color
        self.addSubview(lineView)
    }
    
}

extension UIView {
    
    func bottomLeft() -> CGPoint {
        return CGPoint(x: 0, y: self.frame.height)
    }
    
}
