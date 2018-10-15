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
            self.entries.sort(by: { entry1, entry2 in
                let date1 = (entry1 is MoodInput ? (entry1 as! MoodInput).date : (entry1 as! Answer).date)!
                let date2 = (entry2 is MoodInput ? (entry2 as! MoodInput).date : (entry2 as! Answer).date)!
                return date1 as Date > date2 as Date
            })
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        AnswerDAO.shared.fetchByDay(self.date, completion: { (answers, err) in
            guard err != nil, let answers = answers else {
                return
            }
            self.entries.append(answers)
            didEndedObtainingAnswers = true
            if didEndedObtainingMoods {
                didEndedObtainingData()
            }
        })
        
        MoodDAO.shared.fetchByDay(self.date, completion: { (moods, err) in
            guard err != nil, let moods = moods else {
                return
            }
            self.entries.append(moods)
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
//        return self.entries.count
        return 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: questionCellIdentifier, for: indexPath)
        
//        var cell = UITableViewCell()
//        let entry = self.entries[indexPath.row]
//
//        if let entryMood = entry as? MoodInput {
//            cell = tableView.dequeueReusableCell(withIdentifier: moodCellIdentifier, for: indexPath)
//
//            return cell
//        } else if let entryAnswer = entry as? Answer {
//            cell = tableView.dequeueReusableCell(withIdentifier: questionCellIdentifier, for: indexPath)
//
//            return cell
//
//        }
//
//        return cell
    }
    
}
