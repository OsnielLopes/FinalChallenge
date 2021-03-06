//
//  DailyQuestionView.swift
//  FinalChallenge
//
//  Created Ana Carolina Silva on 16/10/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class DailyQuestionView: UIViewController, DailyQuestionPresenterOutputProtocol, UICollectionViewDataSource, UICollectionViewDelegate {

    // MARK: - Outlets
    @IBOutlet weak var dailyQuestionCollectionView: UICollectionView!
    @IBOutlet var viewButtons: [UIButton]!
    
    // MARK: - Properties
    private let dailyQuestionCellIdentifier = "dailyQuestionCellIdentifier"
    
	// MARK: - Viper Module Properties
	var presenter: DailyQuestionPresenterInputProtocol!

	// MARK: - Override methods
	override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.presenter.loadDailyQuestions()
        
        self.prepareViewController()
        self.prepareButtons()
    }
    
    // MARK: - DailyQuestionPresenterOutputProtocol
    func showLoading(_ loading: Bool) {
        //FIXME: add activity controll on view if loading is true, otherwise, remove loading
    }
    
    func showError(message: String) {
        //FIXME: present the error message on view!
    }
    
    func reloadData() {
        self.dailyQuestionCollectionView.reloadData()
    }

    // MARK: - CollectionView Data Source
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.presenter.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter.numberOfCards(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.dailyQuestionCellIdentifier, for: indexPath)
        
        if let dailyCell = cell as? DailyQuestionCollectionViewCell {
            let question: Question = self.presenter.item(at: indexPath.row)
            
            dailyCell.categoryLabel.text = question.category?.name
            dailyCell.dailyQuestionLabel.text = question.questionText
            
            if let dissertativeAnswer = self.presenter.currentAnswer(for: question) as? DissertationAnswer {
                dailyCell.questionAnswerLabel.isHidden = false
                dailyCell.questionAnswerLabel.text = dissertativeAnswer.text
            }
            
            return dailyCell
        }
        
        return cell
    }
    
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter.didSelectItem(at: indexPath.row)
    }
    
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

    // MARK: - Action
    @IBAction func touchBackButton(_ sender: UIButton) {
        self.presenter.didTouchBackButton()
    }
    
    @IBAction func touchRemoveButton(_ sender: UIButton) {
        if let currentCard = self.dailyQuestionCollectionView.visibleCells.first(where: { return $0.frame.minY < 0 }), let currentIndexPath = self.dailyQuestionCollectionView.indexPath(for: currentCard) {
            self.presenter.removeQuestion(at: currentIndexPath.row)
        }
    }
}
