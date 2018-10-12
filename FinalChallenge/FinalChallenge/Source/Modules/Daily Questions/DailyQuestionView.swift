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
    @IBOutlet var viewButtons: [UIButton]!
    
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
        
        self.prepareViewController()
        self.prepareButtons()
    }

    // MARK: - DailyQuestionPresenterOutputProtocol

	// MARK: - Private Methods
    private func prepareViewController() {
        self.dailyQuestionCollectionView.dataSource = self
        self.dailyQuestionCollectionView.delegate = self
        self.dailyQuestionCollectionView.collectionViewLayout = CenterAndZoomFlowLayout()
    }
    
    private func prepareButtons() {
        for button in self.viewButtons {
            button.layer.cornerRadius = button.frame.width/2
            button.layer.masksToBounds = true
            
            //FIXME: colocar sombra (?)
        }
    }

    // MARK: - CollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter.numberOfCards
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
    }
    
    // MARK: - Action
    @IBAction func touchBackButton(_ sender: UIButton) {
        
    }
    
    @IBAction func touchRemoveButton(_ sender: UIButton) {
        
    }
}
