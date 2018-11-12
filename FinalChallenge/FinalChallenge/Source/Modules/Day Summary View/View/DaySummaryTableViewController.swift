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

class DaySummaryTableViewController: UITableViewController {
    
    var insertTableViewCell: InsertTableViewCell?
    var summaryView: DailySummaryViewController!
    var dailySummaryParentViewController: DailySummaryViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.dailySummaryParentViewController.loadTodayEntries()
    }
    
    // MARK: - UITableViewControllerDelegate and UITableViewControllerDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.dailySummaryParentViewController.numberOfSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dailySummaryParentViewController.numberOfEntries(in: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 && self.dailySummaryParentViewController.shouldShowAddButton() {
            if let addCell = tableView.dequeueReusableCell(withIdentifier: addCellIdentifier, for: indexPath) as? InsertTableViewCell {
                
                addCell.daySummaryTableViewController = self
                addCell.lineView.isHidden = self.dailySummaryParentViewController.shouldDisplayLine(for: indexPath.row)
                self.insertTableViewCell = addCell
                self.dailySummaryParentViewController.loadMoodTypes()
                
                return addCell
            } else {
                return UITableViewCell()
            }
        }
        
        let entry = self.dailySummaryParentViewController.item(at: indexPath.row)
        
        if let entryMood = entry as? MoodInput {
            if let moodCell = tableView.dequeueReusableCell(withIdentifier: moodCellIdentifier) as? MoodInputTableViewCell {
                moodCell.setMood(entryMood)
                moodCell.lineView.isHidden = self.dailySummaryParentViewController.shouldDisplayLine(for: indexPath.row)
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
        
        if indexPath.row == 0 && self.dailySummaryParentViewController.shouldShowAddButton() {
            return 70
        }
        
        switch self.dailySummaryParentViewController.item(at: indexPath.row) {
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
        return UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: self.tableView.frame.width, height: self.dailySummaryParentViewController.headerHeight)))
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.dailySummaryParentViewController.headerHeight
    }
    
    // MARK: - Actions
    func didTapInsertMood(_ moodIndex: Int) {
        self.dailySummaryParentViewController.didTapInsert(mood: moodIndex)
    }
    
    func didTapInsertQuestion(insertButton: UIButton) {
        self.dailySummaryParentViewController.insertQuestionButton = insertButton
        self.dailySummaryParentViewController.didTapInsertQuestion()
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
    
    func didAddedMood(_ result: MoodInput) {
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [IndexPath(row: 1, section: 0)], with: UITableView.RowAnimation.top)
        self.tableView.endUpdates()
        if let insertCell = self.tableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? InsertTableViewCell {
            insertCell.lineView.isHidden = self.dailySummaryParentViewController.shouldDisplayLine(for: 0)
        }
    }
    
}
