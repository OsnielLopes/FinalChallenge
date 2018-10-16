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
    
    var entries: [Any] = []
    
    var moodTypes: [MoodType] = []
    
    var summaryView: DailySummaryViewController!
    
    var shouldShowAddButton = true

    override func viewDidLoad() {
        super.viewDidLoad()
        self.moodTypes = MoodDAO.shared.moodTypes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadData()
    }
    
    func loadData() {
        
        self.shouldShowAddButton = Calendar.current.isDateInToday(self.summaryView.currentDate)
        
        self.entries = []
        self.tableView.reloadData()
        
        var didEndedObtainingAnswers = false
        var didEndedObtainingMoods = false
        
        let didEndedObtainingData = {
            self.entries.sort(by: { entry1, entry2 in
                var date1: NSDate!
                if entry1 is MoodInput {
                    date1 = (entry1 as! MoodInput).date!
                } else if entry1 is Answer {
                    date1 = (entry1 as! Answer).date!
                }
                
                var date2: NSDate!
                if entry2 is MoodInput {
                    date2 = (entry2 as! MoodInput).date!
                } else if entry2 is Answer {
                    date2 = (entry2 as! Answer).date!
                }
                
                return (date1 as Date) > (date2 as Date)
            })
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        AnswerDAO.shared.fetchByDay(self.summaryView.currentDate, completion: { (answers, err) in
            guard err == nil, let answers = answers else {
                return
            }
            self.entries.append(contentsOf: answers)
            didEndedObtainingAnswers = true
            if didEndedObtainingMoods {
                didEndedObtainingData()
            }
        })
        
        MoodDAO.shared.fetchByDay(self.summaryView.currentDate, completion: { (moods, err) in
            guard err == nil, let moods = moods else {
                return
            }
            self.entries.append(contentsOf: moods)
            didEndedObtainingMoods = true
            if didEndedObtainingAnswers {
                didEndedObtainingData()
            }
        })
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.entries.count + (self.shouldShowAddButton ? 1 : 0)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 && self.shouldShowAddButton {
            if let addCell = tableView.dequeueReusableCell(withIdentifier: addCellIdentifier, for: indexPath) as? InsertTableViewCell {
                
                addCell.daySummaryTableViewController = self
                addCell.setButtons()
                
                addCell.lineView.isHidden = self.entries.count == 0
                
                return addCell
            } else {
                return UITableViewCell()
            }
        }
        
        let entry = self.entries[indexPath.row - (self.shouldShowAddButton ? 1 : 0)]

        if let entryMood = entry as? MoodInput {
            if let moodCell = tableView.dequeueReusableCell(withIdentifier: moodCellIdentifier, for: indexPath) as? MoodInputTableViewCell {
                moodCell.setMood(entryMood)
                moodCell.lineView.isHidden = indexPath.row + (!self.shouldShowAddButton ? 1 : 0) == self.entries.count
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
        
        if indexPath.row == 0 && self.shouldShowAddButton {
            return 70
        }
        
        switch self.entries[indexPath.row - (self.shouldShowAddButton ? 1 : 0)] {
        case is Answer:
            return UITableView.automaticDimension
        case is MoodInput:
            return 70
        default:
            break
        }
        return 0
    }
    
    func didTapInsertMood(_ moodIndex: Int) {
        MoodDAO.shared.insertMood(moodType: self.moodTypes[moodIndex], date: Date(), completion: { _, _ in
            self.loadData()
        })
    }
    
    func didTapInsertQuestion() {
        let storyboard = UIStoryboard(name: "DailyQuestion", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DailyQuestionView")
        self.navigationController?.pushViewController(viewController, animated: false)

    }
    
}
