//
//  DailyQuestionView.swift
//  FinalChallenge
//
//  Created Ana Carolina Silva on 16/10/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class DailyQuestionView: UIViewController, DailyQuestionPresenterOutputProtocol {

	// MARK: - Viper Module Properties
	var presenter: DailyQuestionPresenterInputProtocol!

	// MARK: - Override methods
	override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - DailyQuestionPresenterOutputProtocol
    func showLoading(_ loading: Bool) {
        //FIXME: add activity controll on view if loading is true, otherwise, remove loading
    }
    
    func showError(message: String) {
        //FIXME: present the error message on view!
    }
    
    func reloadData() {
        //FIXME: reload collectionView data
    }
    
	// MARK: - Private Methods

}


////
////  DailyQuestionView.swift
////  FinalChallenge
////
////  Created Ana Carolina Silva on 04/10/18.
////  Copyright © 2018. All rights reserved.
////
//
//import UIKit
//
//class DailyQuestionView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
//    
//    // MARK: - Outlets
//    @IBOutlet weak var dailyQuestionCollectionView: UICollectionView!
//    @IBOutlet var viewButtons: [UIButton]!
//    
//    // MARK: - Properties
//    var todayQuestions: [DissertationQuestion] = Array()
//    
//    // MARK: - Viper Module Properties
//    // MARK: Public Properties
//    //    var presenter: DailyQuestionPresenterInputProtocol!
//    
//    // MARK: Private Properties
//    private let cellOldWidth: CGFloat = 284.0
//    private let cellOldHeight: CGFloat = 455.0
//    private let dailyQuestionCellIdentifier = "dailyQuestionCellIdentifier"
//    
//    // MARK: - Override methods
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        guard let todayQuestionsTexts = UserDefaults.standard.object(forKey: "todayQuestions")! as? [String] else {
//            fatalError("Impossible to fetch today questions from NSUserDefaults")
//        }
//        
//        DissertativeQuestionDAO.shared.fetchAll { (questions, error) -> (Void) in
//            guard error == nil && questions != nil else{
//                fatalError("Impossible fetch the dissertative questions from the CoreDate")
//            }
//            
//            self.todayQuestions = (questions?.filter({ (dissertationQuestion) -> Bool in
//                return todayQuestionsTexts.contains(dissertationQuestion.questionText!)
//            }))!
//        }
//        
//        self.prepareViewController()
//        self.prepareButtons()
//    }
//    
//    // MARK: - DailyQuestionPresenterOutputProtocol
//    
//    // MARK: - Private Methods
//    private func prepareViewController() {
//        self.navigationController?.isNavigationBarHidden = true
//        
//        self.dailyQuestionCollectionView.dataSource = self
//        self.dailyQuestionCollectionView.delegate = self
//        self.dailyQuestionCollectionView.collectionViewLayout = CenterAndZoomFlowLayout()
//    }
//    
//    private func prepareButtons() {
//        for button in self.viewButtons {
//            button.layer.cornerRadius = button.frame.width/2
//            button.layer.masksToBounds = true
//            
//            //FIXME: colocar sombra (?)
//        }
//    }
//    
//    // MARK: - CollectionViewDataSource
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.todayQuestions.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.dailyQuestionCellIdentifier, for: indexPath)
//        
//        if let dailyCell = cell as? DailyQuestionCollectionViewCell {
//            dailyCell.categoryLabel.text = self.todayQuestions[indexPath.row].category?.name
//            dailyCell.dailyQuestionLabel.text = self.todayQuestions[indexPath.row].questionText
//            return dailyCell
//        }
//        
//        return cell
//    }
//    
//    // MARK: - CollectionViewDelegate
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let storyboard = UIStoryboard(name: "AnswerQuestion", bundle: nil)
//        let viewController = storyboard.instantiateViewController(withIdentifier: "AnswerQuestionView") as! DissertativeQuestionViewController
//        viewController.question = todayQuestions[indexPath.row]
//        
//        self.navigationController?.pushViewController(viewController, animated: false)
//    }
//    
//    // MARK: - Action
//    @IBAction func touchBackButton(_ sender: UIButton) {
//        self.navigationController?.popViewController(animated: false)
//    }
//    
//    @IBAction func touchRemoveButton(_ sender: UIButton) {
//        
//    }
//} 
