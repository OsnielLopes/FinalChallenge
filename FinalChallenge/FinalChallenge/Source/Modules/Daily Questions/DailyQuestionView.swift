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
    
    // MARK: - Properties
    var todayQuestions: [DissertationQuestion] = Array()
    
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
        
        guard let todayQuestionsTexts = UserDefaults.standard.object(forKey: "todayQuestions")! as? [String] else {
            fatalError("Impossible to fetch today questions from NSUserDefaults")
        }
        
        DissertativeQuestionDAO.shared.fetchAll { (questions, error) -> (Void) in
            guard error == nil && questions != nil else{
                fatalError("Impossible fetch the dissertative questions from the CoreDate")
            }
            
            self.todayQuestions = (questions?.filter({ (dissertationQuestion) -> Bool in
                return todayQuestionsTexts.contains(dissertationQuestion.questionText!)
            }))!
        }
        
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
        return self.todayQuestions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.dailyQuestionCellIdentifier, for: indexPath)
            
        if let dailyCell = cell as? DailyQuestionCollectionViewCell {
            dailyCell.categoryLabel.text = self.todayQuestions[indexPath.row].category?.name
            dailyCell.dailyQuestionLabel.text = self.todayQuestions[indexPath.row].questionText
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
