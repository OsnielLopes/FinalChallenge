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

class DaySummaryTableViewController: UITableViewController {
    
    var entries: [Any] = []
    
    var date: Date = Date()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadData()
    }
    
    func loadData() {
        self.entries = []
        self.tableView.reloadData()
        
        var didEndedObtainingAnswers = false
        var didEndedObtainingMoods = false
        
        let didEndedObtainingData = {
            self.entries.sort(by: {
                let date1 = (($0 is MoodInput) ? ($0 as! MoodInput).date : ($0 as! Answer).date)!
                let date2 = (($1 is MoodInput) ? ($1 as! MoodInput).date : ($1 as! Answer).date)!
                return date1 as Date > date2 as Date
            })
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        AnswerDAO.shared.fetchByDay(self.date, completion: { (answers, err) in
            guard err == nil, let answers = answers else {
                return
            }
            self.entries.append(contentsOf: answers)
            didEndedObtainingAnswers = true
            if didEndedObtainingMoods {
                didEndedObtainingData()
            }
        })
        
        MoodDAO.shared.fetchByDay(self.date, completion: { (moods, err) in
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
        return self.entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let entry = self.entries[indexPath.row]

        if let entryMood = entry as? MoodInput {
            if let moodCell = tableView.dequeueReusableCell(withIdentifier: moodCellIdentifier, for: indexPath) as? MoodInputTableViewCell {
                moodCell.setMood(entryMood)
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
        switch self.entries[indexPath.row] {
        case is Answer:
            return 133
        case is MoodInput:
            return 69
        default:
            break
        }
        return 0
    }
    
}