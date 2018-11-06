//
//  CalendarUICollectionViewFlowLayout.swift
//  FinalChallenge
//
//  Created by Osniel Lopes Teixeira on 04/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

class MonthUICollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    public var weekOfCurrentDay: Int!
    public var expanding: Bool!
    
    override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attr = layoutAttributesForItem(at: itemIndexPath)!.copy() as? UICollectionViewLayoutAttributes, weekOfCurrentDay != nil else {
            return nil
        }
        if !expanding {
            let frame = attr.frame
            if itemIndexPath.row < (weekOfCurrentDay-1)*7 || itemIndexPath.row >= weekOfCurrentDay*7 {
                attr.alpha = 0
                attr.frame = CGRect(x: frame.origin.x, y: frame.origin.y-(frame.height*CGFloat(weekOfCurrentDay-1 > 0 ? weekOfCurrentDay-1 : 1)), width: frame.width, height: frame.height)
            } else {
                attr.frame = CGRect(x: frame.origin.x, y: frame.origin.y-(frame.height*CGFloat(weekOfCurrentDay-1)), width: frame.width, height: frame.height)
            }
        } else {
            let frame = attr.frame
            attr.frame = CGRect(x: frame.origin.x, y: frame.origin.y+(frame.height*CGFloat(weekOfCurrentDay-1)), width: frame.width, height: frame.height)
        }
        return attr
    }
    
    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attr = layoutAttributesForItem(at: itemIndexPath)!.copy() as? UICollectionViewLayoutAttributes, weekOfCurrentDay != nil else {
            return nil
        }
        if expanding {
            if itemIndexPath.row < (weekOfCurrentDay-1)*7 || itemIndexPath.row >= weekOfCurrentDay*7 {
                attr.alpha = 0
                let frame = attr.frame
                attr.frame = CGRect(x: frame.origin.x, y: frame.origin.y-(frame.height*CGFloat(weekOfCurrentDay-1)), width: frame.width, height: frame.height)
            }
            
        }
        return attr
    }
}
