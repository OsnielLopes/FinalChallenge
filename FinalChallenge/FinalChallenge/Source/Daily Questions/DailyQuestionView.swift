//
//  DailyQuestionView.swift
//  FinalChallenge
//
//  Created Ana Carolina Silva on 04/10/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class DailyQuestionView: UIViewController, DailyQuestionPresenterOutputProtocol, UICollectionViewDataSource, UICollectionViewDelegate {

    // MARK: - Outlets
    @IBOutlet weak var dailyQuestionCollectionView: UICollectionView!
    
	// MARK: - Viper Module Properties
    // MARK: Public Properties
    var presenter: DailyQuestionPresenterInputProtocol!
    
    // MARK: Private Properties
    private let cellOldWidth: CGFloat = 284.0
    private let cellOldHeight: CGFloat = 455.0
    private let dailyQuestionCellIdentifier = "dailyQuestionCellIdentifier"

	// MARK: - Override methods
	override func viewDidLoad() {
        super.viewDidLoad()
        
        self.resizeCollectionViewCell()
        
        self.dailyQuestionCollectionView.dataSource = self
        self.dailyQuestionCollectionView.delegate = self
    }

    // MARK: - DailyQuestionPresenterOutputProtocol

	// MARK: - Private Methods
    private func resizeCollectionViewCell() {
        let newHeight = self.dailyQuestionCollectionView.bounds.size.height
        let newWidth = (self.cellOldWidth/self.cellOldHeight) * newHeight
        
        let insetX = (view.bounds.width - newWidth) / 2.0
        let insetY: CGFloat = 20.0
        
        if let layout = self.dailyQuestionCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: newWidth, height: newHeight)
        }
        
        self.dailyQuestionCollectionView.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
    }

    // MARK: - CollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.dailyQuestionCellIdentifier, for: indexPath)
            
        if let dailyCell = cell as? DailyQuestionCollectionViewCell {
            dailyCell.categoryLabel.text = "Relationship"
            dailyCell.dailyQuestionLabel.text = "What could I do to improve my relashionship with my frinds and family members?"
            return dailyCell
        }
        
        return cell
    }
    
    // MARK: - CollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if let layout = self.dailyQuestionCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
            
            var offset = targetContentOffset.pointee
            let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
            let roundedIndex = round(index)
            
            offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
            targetContentOffset.pointee = offset
        }
    }
}
