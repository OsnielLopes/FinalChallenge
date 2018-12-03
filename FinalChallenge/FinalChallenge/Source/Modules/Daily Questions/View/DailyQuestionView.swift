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
    
    var shouldReloadDailyQuestions = true
    
    var currentCard: DailyQuestionCollectionViewCell?

	// MARK: - Override methods
	override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        if self.shouldReloadDailyQuestions {
            self.presenter.loadDailyQuestions()
        }
        
        self.prepareViewController()
        self.prepareButtons()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let currentCard = self.currentCard, let currentIndexPath = self.dailyQuestionCollectionView.indexPath(for: currentCard) {
            self.dailyQuestionCollectionView.scrollToItem(at: currentIndexPath, at: [.centeredHorizontally, .centeredVertically], animated: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.currentCard = self.dailyQuestionCollectionView.visibleCells.first(where: { $0.frame.minY < 0 }) as? DailyQuestionCollectionViewCell
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
        self.shouldReloadDailyQuestions = false
        if let selectedCell = self.dailyQuestionCollectionView.cellForItem(at: indexPath) as? DailyQuestionCollectionViewCell {
            selectedCell.cornerView.hero.id = "openedQuestion"
        }
        
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
            button.dropShadow(color: #colorLiteral(red: 0.01960784314, green: 0.06274509804, blue: 0.07843137255, alpha: 1), opacity: 0.3, offSet: CGSize(width: 0, height: 2), radius: 2, scale: true)
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
