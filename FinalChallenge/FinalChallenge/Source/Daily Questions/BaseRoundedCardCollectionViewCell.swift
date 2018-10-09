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
    public weak var shadowView: UIView?
    private var scale: CGAffineTransform?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        self.configureGestureRecognizer()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.configureShadow()
    }
    
    // MARK: - Shadow
    private func configureShadow() {
        // Shadow View
        self.shadowView?.removeFromSuperview()
        let shadowView = UIView(frame: CGRect(x: -BaseRoundedCardCollectionViewCell.kInnerMargin,
                                              y: -BaseRoundedCardCollectionViewCell.kInnerMargin,
                                              width: (bounds.width * 1.05) + (2 * BaseRoundedCardCollectionViewCell.kInnerMargin),
                                              height: (bounds.height * 1.05) + (2 * BaseRoundedCardCollectionViewCell.kInnerMargin)))
        insertSubview(shadowView, at: 0)
        self.shadowView = shadowView
        
        // Roll/Pitch Dynamic Shadow
        if self.motionManager.isDeviceMotionAvailable {
            self.motionManager.deviceMotionUpdateInterval = 0.02
            self.motionManager.startDeviceMotionUpdates(to: .main, withHandler: { (motion, error) in
                if let motion = motion {
                    let pitch = motion.attitude.pitch * 10 // x-axis
                    let roll = motion.attitude.roll * 10 // y-axis
                    self.applyShadow(width: CGFloat(roll), height: CGFloat(pitch))
                }
            })
        }
    }
    
    private func applyShadow(width: CGFloat, height: CGFloat) {
        if let shadowView = self.shadowView {
            let shadowPath = UIBezierPath(roundedRect: shadowView.bounds, cornerRadius: 10.0)
            shadowView.layer.masksToBounds = false
            shadowView.layer.shadowRadius = 8.0
            shadowView.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
            shadowView.layer.shadowOffset = CGSize(width: width, height: height)
            shadowView.layer.shadowOpacity = 0.15
            shadowView.layer.shadowPath = shadowPath.cgPath
        }
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
