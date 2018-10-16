//
//  DailyQuestionView.swift
//  FinalChallenge
//
//  Created Ana Carolina Silva on 04/10/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class DailyQuestionView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    // MARK: - Outlets
    @IBOutlet weak var dailyQuestionCollectionView: UICollectionView!
    @IBOutlet var viewButtons: [UIButton]!
    
	// MARK: - Viper Module Properties
    // MARK: Public Properties
//    var presenter: DailyQuestionPresenterInputProtocol!
    
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
        self.navigationController?.isNavigationBarHidden = true
        
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
        return 3
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
        let storyboard = UIStoryboard(name: "AnswerQuestion", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AnswerQuestionView")
        
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    
    // MARK: - Action
    @IBAction func touchBackButton(_ sender: UIButton) {
        
    }
    
    @IBAction func touchRemoveButton(_ sender: UIButton) {
        
    }
}
