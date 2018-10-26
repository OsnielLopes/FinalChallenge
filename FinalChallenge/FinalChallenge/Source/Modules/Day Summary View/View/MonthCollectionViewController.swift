//
//  MonthCollectionViewController.swift
//  FinalChallenge
//
//  Created by Osniel Lopes Teixeira on 22/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MonthCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var originalMonthDays: [Date?]!
    var currentMonthDays: [Date?] = []
    var cellWidth: CGFloat!
    let calendar = Calendar(identifier: .gregorian)
    var referenceDay: Date!
    var indexOfFirstDay: Int!
    
    init(collectionViewLayout layout: UICollectionViewLayout, referenceDay: Date) {
        super.init(collectionViewLayout: layout)
        self.referenceDay = referenceDay
        let daysRange = calendar.range(of: .day, in: .month, for: referenceDay)
        let currentDay = calendar.component(.day, from: referenceDay)
        indexOfFirstDay = calendar.component(.weekday, from: calendar.date(byAdding: .day, value: -currentDay+1, to: referenceDay)!)-1
        currentMonthDays.append(contentsOf: Array(repeating: nil, count: indexOfFirstDay))
        for i in -currentDay+1...daysRange!.count-currentDay {
            currentMonthDays.append(calendar.date(byAdding: .day, value: i, to: referenceDay))
        }
        originalMonthDays = currentMonthDays
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = UIColor.white
        self.collectionView!.register(MonthCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        guard let cell = self.collectionView.cellForItem(at: IndexPath(row: indexOfFirstDay, section: 0)) as? MonthCollectionViewCell else { return }
        if calendar.component(.month, from: Date()) != calendar.component(.month, from: cell.day) {
            collectionView.selectItem(at: collectionView.indexPath(for: cell), animated: false, scrollPosition: .centeredHorizontally)
        } else {
            collectionView.selectItem(at: IndexPath(row: calendar.component(.day, from: referenceDay)+indexOfFirstDay-1, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        }
    }
    
    //MARK: - UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentMonthDays.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MonthCollectionViewCell
        cell.day = originalMonthDays[indexPath.row]
        cell.background.layer.cornerRadius = cell.bounds.height/2
        return cell
    }
    
    //MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let cell = collectionView.cellForItem(at: indexPath) as? MonthCollectionViewCell else { return false }
        return cell.day != nil
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for cell in collectionView.visibleCells {
            if collectionView.indexPath(for: cell) == indexPath {
                cell.isSelected = true
            } else {
                collectionView.deselectItem(at: collectionView.indexPath(for: cell)!, animated: true)
            }
        }
        guard let parentViewController = self.parent as? CalendarViewController else {
            print("Impossible to downcast the parentViewController to CalendarViewController")
            return
        }
        parentViewController.updateSummaryView()
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        return !collectionView.indexPathsForSelectedItems!.contains(indexPath)
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let heightPerItem = collectionView.bounds.height/6
        return CGSize(width: self.cellWidth, height: heightPerItem)
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
    
    // MARK: - Auxiliar Functions
    
    func updateFor(referenceDay: Date){
        self.referenceDay = referenceDay
        let daysRange = calendar.range(of: .day, in: .month, for: referenceDay)
        let currentDay = calendar.component(.day, from: referenceDay)
        indexOfFirstDay = calendar.component(.weekday, from: calendar.date(byAdding: .day, value: -currentDay+1, to: referenceDay)!)-1
        currentMonthDays = []
        currentMonthDays.append(contentsOf: Array(repeating: nil, count: indexOfFirstDay))
        for i in -currentDay+1...daysRange!.count-currentDay {
            currentMonthDays.append(calendar.date(byAdding: .day, value: i, to: referenceDay))
        }
        originalMonthDays = currentMonthDays
        
        self.collectionView.reloadData()
        
        self.collectionView.performBatchUpdates(nil) { (didComplete) in
            guard let cell = self.collectionView.cellForItem(at: IndexPath(row: self.indexOfFirstDay, section: 0)) as? MonthCollectionViewCell else { return }
            if self.calendar.component(.month, from: Date()) != self.calendar.component(.month, from: cell.day) {
                self.collectionView.selectItem(at: self.collectionView.indexPath(for: cell), animated: false, scrollPosition: .centeredHorizontally)
            } else {
                self.collectionView.selectItem(at: IndexPath(row: self.calendar.component(.day, from: referenceDay)+self.indexOfFirstDay-1, section: 0), animated: true, scrollPosition: .centeredHorizontally)
            }
        }
        
    }
    
}
