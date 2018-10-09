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
        
        self.dailyQuestionCollectionView.dataSource = self
        self.dailyQuestionCollectionView.delegate = self
        self.dailyQuestionCollectionView.collectionViewLayout = CenterAndZoomFlowLayout()
    }

    // MARK: - DailyQuestionPresenterOutputProtocol

	// MARK: - Private Methods

    // MARK: - CollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //FIXME: Call Presenter to ask how many items the array has
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
        //FIXME: Redirect to answerView
//        guard let cell = self.dailyQuestionCollectionView.visibleCells.first(where: { $0.frame.minY < 0 }), let dailyQuestionCell = cell as? DailyQuestionCollectionViewCell else { return }
        for cell in self.dailyQuestionCollectionView.visibleCells {
            guard let dailyQuestionCell = cell as? DailyQuestionCollectionViewCell else { return }
            if dailyQuestionCell.frame.minY >= 0 {
                dailyQuestionCell.shadowView?.removeFromSuperview()
            }
        }
//        dailyQuestionCell.shadowView.remove
    }
}
