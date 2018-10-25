//
//  DaySummaryTableViewController.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 10/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

fileprivate let moodCellIdentifier = "moodCellIdentifier"
fileprivate let questionCellIdentifier = "questionCellIdentifier"
fileprivate let addCellIdentifier = "addCellIdentifier"

class DaySummaryTableViewController: UITableViewController, DaySummaryPresenterOutputProtocol {
    
    
    var transitionAnimator = PopToScreenSizeTransitionAnimation()
    var insertTableViewCell: InsertTableViewCell?
    var summaryView: DailySummaryViewController!
    let headerHeight: CGFloat = 150.0
    var insertButton: UIButton?
    
    // MARK: - Viper Module Properties
    var presenter: DaySummaryPresenterInputProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.loadTodayEntries()
    }
    
    // MARK: - UITableViewControllerDelegate and UITableViewControllerDataSource
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.presenter.numberOfSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.numberOfEntries(in: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 && self.presenter.shouldShowAddButton() {
            if let addCell = tableView.dequeueReusableCell(withIdentifier: addCellIdentifier, for: indexPath) as? InsertTableViewCell {
                
                addCell.daySummaryTableViewController = self
                addCell.lineView.isHidden = self.presenter.shouldDisplayLine(for: indexPath.row)
                self.insertTableViewCell = addCell
                self.presenter.loadMoodTypes()
                
                return addCell
            } else {
                return UITableViewCell()
            }
        }
        
        let entry = self.presenter.item(at: indexPath.row)
        
        if let entryMood = entry as? MoodInput {
            if let moodCell = tableView.dequeueReusableCell(withIdentifier: moodCellIdentifier, for: indexPath) as? MoodInputTableViewCell {
                moodCell.setMood(entryMood)
                moodCell.lineView.isHidden = self.presenter.shouldDisplayLine(for: indexPath.row)
                return moodCell
            }
        } else if let entryAnswer = entry as? Answer {
            if let answerCell = tableView.dequeueReusableCell(withIdentifier: questionCellIdentifier, for: indexPath) as? AnswerTableViewCell {
                answerCell.setAnswer(entryAnswer)
                return answerCell
            }
        }

        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 && self.presenter.shouldShowAddButton() {
            return 70
        }
        
        switch self.presenter.item(at: indexPath.row) {
        case is Answer:
            return UITableView.automaticDimension
        case is MoodInput:
            return 70
        default:
            break
        }
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: self.tableView.frame.width, height: self.headerHeight)))
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.headerHeight
    }
    
    // MARK: - Actions
    func didTapInsertMood(_ moodIndex: Int) {
        self.presenter.didTapInsert(mood: moodIndex)
    }
    
    func didTapInsertQuestion(insertButton: UIButton) {
        self.insertButton = insertButton
        self.presenter.didTapInsertQuestion()
//        let storyboard = UIStoryboard(name: "BreathingView", bundle: nil)
//        if let viewController = storyboard.instantiateViewController(withIdentifier: "breathingView") as? BreathingViewController {
//            viewController.transitioningDelegate = self
//            viewController.daySummaryViewController = self
//            self.present(viewController, animated: true, completion: nil)
//        }
    }
    
    // MARK: - DaySummaryPresenterOutputProtocol
    func showLoading(_ loading: Bool) {
        //FIXME: add activity controll on view if loading is true, otherwise, remove loading
    }
    
    func showError(message: String) {
        //FIXME: present the error message on view!
    }
    
    func didFetchEntries() {
        self.tableView.reloadData()
    }
    
    func didFetch(moodTypes: [MoodType]) {
        self.insertTableViewCell?.setButtons(forMoodTypes: moodTypes)
    }
    
    func didAddedMood() {
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [IndexPath.init(row: 1, section: 0)], with: UITableView.RowAnimation.top)
        self.tableView.endUpdates()
    }
    
    
}

extension DaySummaryTableViewController: UIViewControllerTransitioningDelegate {
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        guard let insertButton = self.insertButton else {
            return nil
        }
        
        self.transitionAnimator.transitionMode = .present
        
        var originPoint = insertButton.layer.presentation()!.frame.origin
        originPoint.x += insertButton.layer.presentation()!.frame.width / 2
        originPoint.y += self.headerHeight
        
        self.transitionAnimator.startingPoint = self.view.convert(originPoint, to: nil)
        self.transitionAnimator.bubbleColor = insertButton.backgroundColor!
        
        return self.transitionAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let insertButton = self.insertButton else {
            return nil
        }
        self.transitionAnimator.transitionMode = .pop
        self.transitionAnimator.startingPoint = insertButton.center
        self.transitionAnimator.bubbleColor = insertButton.backgroundColor!
        
        return nil
    }
    
}
