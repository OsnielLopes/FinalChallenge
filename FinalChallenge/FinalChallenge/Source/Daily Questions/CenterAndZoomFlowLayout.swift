//
//  CenterAndZoomFlowLayout.swift
//  FinalChallenge
//
//  Created by Ana Carolina Silva on 08/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

class CenterAndZoomFlowLayout: UICollectionViewFlowLayout {
    
    let activeDistance: CGFloat = 200
    static let zoomFactor: CGFloat = 0.1
    
    private let cellOldWidth: CGFloat = 284.0
    private let cellOldHeight: CGFloat = 455.0
    
    override init() {
        super.init()
        
        self.scrollDirection = .horizontal
        self.minimumLineSpacing = 30
        self.minimumInteritemSpacing = 60
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepare() {
        guard let collectionView = collectionView else { fatalError() }
        
        var newHeight = collectionView.bounds.size.height
        var newWidth = (self.cellOldWidth/self.cellOldHeight) * newHeight
        
        newHeight = newHeight * (1 - CenterAndZoomFlowLayout.zoomFactor)
        newWidth = newWidth * (1 - CenterAndZoomFlowLayout.zoomFactor)
        
        let insetX = (UIScreen.main.bounds.width - newWidth) / 2.0
        let insetY: CGFloat = 20.0
        
        if let layout = collectionView.collectionViewLayout as? CenterAndZoomFlowLayout {
            layout.itemSize = CGSize(width: newWidth, height: newHeight)
        }
        
        collectionView.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        
        super.prepare()
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = collectionView else { return nil }
        let rectAttributes = super.layoutAttributesForElements(in: rect)!.map { $0.copy() as! UICollectionViewLayoutAttributes }
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.frame.size)
        
        // Make the cells be zoomed when they reach the center of the screen
//        for (attributes, cell) in rectAttributes where attributes.frame.intersects(visibleRect) {
//            let distance = visibleRect.midX - attributes.center.x
//            let normalizedDistance = distance / self.activeDistance
//
//            if distance.magnitude < self.activeDistance {
//                let zoom = 1 + CenterAndZoomFlowLayout.zoomFactor * (1 - normalizedDistance.magnitude)
//                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1)
//                attributes.zIndex = Int(zoom.rounded())
//
//
//
//
//
//                guard let dailyQuestionsCells = collectionView.visibleCells as? [DailyQuestionCollectionViewCell] else { return rectAttributes }
//
//
//
//                let cell = dailyQuestionsCells.first { (cell) -> Bool in
//                    cell.frame.intersects(visibleRect)
//                }
//
//                print(cell)
//            }
//        }
        guard let visibleCells = collectionView.visibleCells as? [DailyQuestionCollectionViewCell] else { return rectAttributes }
        
        for cell in rectAttributes where cell.frame.intersects(visibleRect) {
            print(cell)
        }
        
        return rectAttributes
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return .zero }
        
        // Add some snapping behaviour so that the zoomed cell is always centered
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.frame.width, height: collectionView.frame.height)
        guard let rectAttributes = super.layoutAttributesForElements(in: targetRect) else { return .zero }
        
        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let horizontalCenter = proposedContentOffset.x + collectionView.frame.width / 2
        
        for layoutAttributes in rectAttributes {
            let itemHorizontalCenter = layoutAttributes.center.x
            if (itemHorizontalCenter - horizontalCenter).magnitude < offsetAdjustment.magnitude {
                offsetAdjustment = itemHorizontalCenter - horizontalCenter
            } 
        }
        
        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        // Invalidate layout so that every cell get a chance to be zoomed when it reaches the center of the screen
        return true
    }
    
    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forBoundsChange: newBounds) as! UICollectionViewFlowLayoutInvalidationContext
        context.invalidateFlowLayoutDelegateMetrics = newBounds.size != collectionView?.bounds.size
        return context
    }
}
