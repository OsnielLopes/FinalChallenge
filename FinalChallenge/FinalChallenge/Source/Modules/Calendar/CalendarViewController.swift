//
//  CalendarViewController.swift
//  FinalChallenge
//
//  Created by Osniel Lopes Teixeira on 02/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - IBOutlets
    @IBOutlet weak var currentMonthLabel: UILabel!
    @IBOutlet weak var currentMonthLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var currentMonthTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var nextMonthLabel: UILabel!
    @IBOutlet weak var nextMonthLabelCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var weekdays: UIStackView!
    @IBOutlet weak var weekDaysTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var firstWeekdayLabelWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var daysColletionView: UICollectionView!
    
    
    // MARK: - Variables
    var largeCalendarView = true
    var referenceDay = Date()
    var currentMonthLabelInitialFrame: CGRect!
    var originalMonthDays: [Date?] = []
    var currentMonthDays: [Date?] = []
    var calendar = Calendar(identifier: .gregorian)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextMonthLabelCenterConstraint.constant = self.view.frame.width/2
        referenceDay = calendar.date(byAdding: .day, value: 14, to: referenceDay)!
        
        firstWeekdayLabelWidthConstraint.constant = (self.view.frame.width - 60) / 7
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.dateFormat = "MMMM"
        currentMonthLabel.text = dateFormatter.string(from: referenceDay)
        nextMonthLabel.text = dateFormatter.string(from: calendar.date(byAdding: .month, value: 1, to: referenceDay)!)
        currentMonthLabel.layer.anchorPoint = CGPoint(x: 0, y: 0)
        currentMonthLabelInitialFrame = currentMonthLabel.frame
        currentMonthLeadingConstraint.constant -= currentMonthLabel.intrinsicContentSize.width/2
        currentMonthLeadingConstraint.constant += (firstWeekdayLabelWidthConstraint.constant/2)-weekdays.arrangedSubviews.first!.intrinsicContentSize.width/2
        currentMonthTopConstraint.constant -= currentMonthLabelInitialFrame.height/2
        
        daysColletionView.dataSource = self
        daysColletionView.delegate = self
        daysColletionView.allowsSelection = true
        daysColletionView.allowsMultipleSelection = true
        
        var dateComponentes = calendar.dateComponents(in: TimeZone.current, from: referenceDay)
        dateComponentes.setValue(1, for: .day)
        currentMonthDays.append(contentsOf: Array(repeating: nil, count: calendar.component(.weekday, from: calendar.date(from: dateComponentes)!) - 1))
        let daysRange = calendar.range(of: .day, in: .month, for: referenceDay)
        for i in 1...daysRange!.count {
            currentMonthDays.append(calendar.date(bySetting: .day, value: i, of: Date()))
        }
        originalMonthDays = currentMonthDays
        daysColletionView.collectionViewLayout = CalendarUICollectionViewFlowLayout()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        for case let cell as CalendarCollectionViewCell in daysColletionView.visibleCells {
            guard cell.day != nil else { continue }
            let isToday = calendar.component(.year, from: Date()) == calendar.component(.year, from: cell.day) && calendar.component(.month, from: Date()) == calendar.component(.month, from: cell.day) && calendar.component(.day, from: Date()) == calendar.component(.day, from: cell.day)
            if isToday {
                daysColletionView.selectItem(at: daysColletionView.indexPath(for: cell), animated: false, scrollPosition: .centeredHorizontally)
            }
        }
    }
    
    //MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CalendarCollectionViewCell else { return false }
        return cell.day != nil
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for cell in collectionView.visibleCells {
            if collectionView.indexPath(for: cell) == indexPath {
                cell.isSelected = true
            } else {
                collectionView.deselectItem(at: collectionView.indexPath(for: cell)!, animated: true)
            }
            
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        return !collectionView.indexPathsForSelectedItems!.contains(indexPath)
    }

    //MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentMonthDays.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "day", for: indexPath) as! CalendarCollectionViewCell
        cell.day = originalMonthDays[indexPath.row]
        cell.background.layer.cornerRadius = cell.bounds.height/2
        return cell
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let heightPerItem = collectionView.bounds.height/6
        return CGSize(width: (firstWeekdayLabelWidthConstraint.constant)-0.00001, height: heightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //MARK: - IBActions
    
    @IBAction func changeTheCalendarStatus() {
        
        return
        
        let weekOfCurrentDay = calendar.component(.weekOfMonth, from: (daysColletionView.cellForItem(at: daysColletionView.indexPathsForSelectedItems!.first!) as! CalendarCollectionViewCell).day)
        (daysColletionView.collectionViewLayout as! CalendarUICollectionViewFlowLayout).expanding = !largeCalendarView
        
        if largeCalendarView {
            
            var indexOfItemsToBeRemoved: [Int] = []
            for i in 0..<currentMonthDays.count {
                if i < (weekOfCurrentDay-1)*7 || i >= weekOfCurrentDay*7 {
                    indexOfItemsToBeRemoved.append(i)
                }
            }
            
            let indexPathOfItemsToBeRemoved = indexOfItemsToBeRemoved.map { (i) -> IndexPath in
                return IndexPath(item: i, section: 0)
            }
            
            for indexPath in daysColletionView!.indexPathsForSelectedItems! {
                if indexPathOfItemsToBeRemoved.contains(indexPath) {
                    fatalError("Trying to remove a selected item.")
                }
            }
            
            indexOfItemsToBeRemoved.reverse()
            for index in indexOfItemsToBeRemoved {
                currentMonthDays.remove(at: index)
            }

            (daysColletionView.collectionViewLayout as! CalendarUICollectionViewFlowLayout).weekOfCurrentDay = weekOfCurrentDay
            
            UIView.animate(withDuration: 1) {
                self.currentMonthLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                self.nextMonthLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                self.nextMonthLabel.alpha = 0
                self.weekDaysTopConstraint.constant -= self.currentMonthLabelInitialFrame.height/2
                self.view.layoutIfNeeded()
                self.daysColletionView.deleteItems(at: indexPathOfItemsToBeRemoved)
            }
            
        } else {
            
            var indexPathOfItemsToBeAdded: [IndexPath] = []
            for i in 0..<originalMonthDays.count {
                if i < (weekOfCurrentDay-1)*7 || i >= weekOfCurrentDay*7 {
                    indexPathOfItemsToBeAdded.append(IndexPath(item: i, section: 0))
                    currentMonthDays.insert(originalMonthDays[i], at: i)
                }
            }
            
            UIView.animate(withDuration: 1) {
                self.currentMonthLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.nextMonthLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.nextMonthLabel.alpha = 1
                self.weekDaysTopConstraint.constant += self.currentMonthLabelInitialFrame.height/2
                self.view.layoutIfNeeded()
                self.daysColletionView.insertItems(at: indexPathOfItemsToBeAdded)
                
            }
            //            daysColletionView.insertItems(at: [IndexPath(row: 0, section: 0)])
        }
        
        largeCalendarView = !largeCalendarView
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
}
