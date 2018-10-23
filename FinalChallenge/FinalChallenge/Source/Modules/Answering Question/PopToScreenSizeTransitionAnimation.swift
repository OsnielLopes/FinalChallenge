//
//  PopToScreenSizeTransitionAnimation.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 18/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation
import UIKit

class PopToScreenSizeTransitionAnimation: NSObject  {
    
    @objc open var startingPoint = CGPoint.zero {
        didSet {
            bubble.center = startingPoint
        }
    }
    
    @objc open var duration = 0.5
    
    @objc open var transitionMode: BubbleTransitionMode = .present
    
    @objc open var bubbleColor: UIColor = .white
    
    open fileprivate(set) var bubble = UIView()

    @objc public enum BubbleTransitionMode: Int {
        case present, dismiss, pop
    }
    
}

extension PopToScreenSizeTransitionAnimation: UIViewControllerAnimatedTransitioning {
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        let fromViewController = transitionContext.viewController(forKey: .from)
        let toViewController = transitionContext.viewController(forKey: .to)
        
        if self.transitionMode == .present {
            fromViewController?.beginAppearanceTransition(false, animated: true)
            if toViewController?.modalPresentationStyle == .custom {
                toViewController?.beginAppearanceTransition(true, animated: true)
            }
            
            let presentedControllerView = transitionContext.view(forKey: .to)!
            let originalCenter = presentedControllerView.center
            let originalSize = presentedControllerView.frame.size
            
            self.bubble = UIView()
            self.bubble.frame = frameForBubble(originalCenter, size: originalSize, start: startingPoint)
            self.bubble.layer.cornerRadius = self.bubble.frame.size.height / 2
            self.bubble.center = startingPoint
            self.bubble.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            self.bubble.backgroundColor = bubbleColor
            containerView.addSubview(self.bubble)
            
            presentedControllerView.center = startingPoint
            presentedControllerView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            presentedControllerView.alpha = 0
            containerView.addSubview(presentedControllerView)
            
            UIView.animate(withDuration: duration, animations: {
                self.bubble.transform = CGAffineTransform.identity
                presentedControllerView.transform = CGAffineTransform.identity
                presentedControllerView.alpha = 1
                presentedControllerView.center = originalCenter
            }, completion: { (_) in
                transitionContext.completeTransition(true)
                self.bubble.isHidden = true
                if toViewController?.modalPresentationStyle == .custom {
                    toViewController?.endAppearanceTransition()
                }
                fromViewController?.endAppearanceTransition()
            })
        } else {
            if fromViewController?.modalPresentationStyle == .custom {
                fromViewController?.beginAppearanceTransition(false, animated: true)
            }
            toViewController?.beginAppearanceTransition(true, animated: true)
            
            let key: UITransitionContextViewKey = (transitionMode == .pop) ? .to : .from
            let returningControllerView = transitionContext.view(forKey: key)!
            let originalCenter = returningControllerView.center
            let originalSize = returningControllerView.frame.size
            
            self.bubble.frame = frameForBubble(originalCenter, size: originalSize, start: startingPoint)
            self.bubble.layer.cornerRadius = self.bubble.frame.size.height / 2
            self.bubble.backgroundColor = bubbleColor
            self.bubble.center = startingPoint
            self.bubble.isHidden = false
            
            UIView.animate(withDuration: duration, animations: {
                self.bubble.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                returningControllerView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                returningControllerView.center = self.startingPoint
                returningControllerView.alpha = 0
                
                if self.transitionMode == .pop {
                    containerView.insertSubview(returningControllerView, belowSubview: returningControllerView)
                    containerView.insertSubview(self.bubble, belowSubview: returningControllerView)
                }
            }, completion: { (completed) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                
                if !transitionContext.transitionWasCancelled {
                    returningControllerView.center = originalCenter
                    returningControllerView.removeFromSuperview()
                    self.bubble.removeFromSuperview()
                    
                    if fromViewController?.modalPresentationStyle == .custom {
                        fromViewController?.endAppearanceTransition()
                    }
                    toViewController?.endAppearanceTransition()
                }
            })
        }
    }
    
    func frameForBubble(_ originalCenter: CGPoint, size originalSize: CGSize, start: CGPoint) -> CGRect {
        let lengthX = fmax(start.x, originalSize.width - start.x)
        let lengthY = fmax(start.y, originalSize.height - start.y)
        let offset = sqrt(lengthX * lengthX + lengthY * lengthY) * 2
        let size = CGSize(width: offset, height: offset)
        
        return CGRect(origin: CGPoint.zero, size: size)
    }

}
