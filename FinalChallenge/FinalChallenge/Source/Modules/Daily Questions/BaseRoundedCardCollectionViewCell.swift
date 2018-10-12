//
//  BaseRoundedCardCollectionViewCell.swift
//  FinalChallenge
//
//  Created by Ana Carolina Silva on 05/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit
import CoreMotion

class BaseRoundedCardCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
//    internal static let cellHeight: CGFloat = 470.0
    private static let kInnerMargin: CGFloat = 20.0
    private let motionManager = CMMotionManager()
    private var longPressGestureRecognizer: UILongPressGestureRecognizer? = nil
    private var isPressed: Bool = false
    private weak var shadowView: UIView?
    private var scale: CGAffineTransform?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        self.configureGestureRecognizer()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - Gesture Recognizer
//    private func configureGestureRecognizer() {
//        // Long Press Gesture Recognizer
//        self.longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(gestureRecognizer:)))
//        self.longPressGestureRecognizer?.minimumPressDuration = 0.05
//        addGestureRecognizer(self.longPressGestureRecognizer!)
//    }
//
//    @objc private func handleLongPressGesture(gestureRecognizer: UILongPressGestureRecognizer) {
//        if gestureRecognizer.state == .began {
//            self.handleLongPressBegan()
//        } else if gestureRecognizer.state == .ended || gestureRecognizer.state == .cancelled {
//            self.handleLongPressEnded()
//        }
//    }
//
//    private func handleLongPressBegan() {
//        guard !isPressed else {
//            return
//        }
//
//        self.isPressed = true
//        UIView.animate(withDuration: 0.5,
//                       delay: 0.0,
//                       usingSpringWithDamping: 0.5,
//                       initialSpringVelocity: 0.2,
//                       options: .beginFromCurrentState,
//                       animations: {
//                        self.scale = CGAffineTransform(scaleX: (1 - CenterAndZoomFlowLayout.zoomFactor), y: (1 - CenterAndZoomFlowLayout.zoomFactor))
//                        self.transform = CGAffineTransform.identity
//        }, completion: nil)
//    }
//
//    private func handleLongPressEnded() {
//        guard self.isPressed else {
//            return
//        }
//
//        UIView.animate(withDuration: 0.5,
//                       delay: 0.0,
//                       usingSpringWithDamping: 0.9,
//                       initialSpringVelocity: 0.2,
//                       options: .beginFromCurrentState,
//                       animations: {
//                        self.transform = CGAffineTransform.inverted(self.scale ?? CGAffineTransform.identity)()
//        }) { (finished) in
//            self.isPressed = false
//        }
//    }
}
