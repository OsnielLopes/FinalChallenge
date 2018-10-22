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
    
    var referenceDay = Date()
    var originalMonthDays: [Date?] = []
    var currentMonthDays: [Date?] = []
    var cellWidth: CGFloat!
    let calendar = Calendar(identifier: .gregorian)
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = UIColor.white
        self.collectionView!.register(MonthCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.delegate = self
        
        let daysRange = calendar.range(of: .day, in: .month, for: referenceDay)
        let currentDay = calendar.component(.day, from: referenceDay)
        currentMonthDays.append(contentsOf: Array(repeating: nil, count: calendar.component(.weekday, from: calendar.date(byAdding: .day, value: -currentDay+1, to: Date())!)-1))
        for i in -currentDay+1...daysRange!.count-currentDay {
            currentMonthDays.append(calendar.date(byAdding: .day, value: i, to: Date()))
        }
        originalMonthDays = currentMonthDays
    }
    
    override func viewDidAppear(_ animated: Bool) {
        for case let cell as MonthCollectionViewCell in self.collectionView.visibleCells {
            guard cell.day != nil else { continue }
            if calendar.component(.month, from: Date()) != calendar.component(.month, from: cell.day) {
                collectionView.selectItem(at: collectionView.indexPath(for: cell), animated: false, scrollPosition: .centeredHorizontally)
                break
            } else {
                let isToday = calendar.component(.year, from: Date()) == calendar.component(.year, from: cell.day) && calendar.component(.month, from: Date()) == calendar.component(.month, from: cell.day) && calendar.component(.day, from: Date()) == calendar.component(.day, from: cell.day)
                if isToday {
                    collectionView.selectItem(at: collectionView.indexPath(for: cell), animated: false, scrollPosition: .centeredHorizontally)
                }
            }
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
        guard let cell = collectionView.cellForItem(at: indexPath) as? CalendarCollectionViewCell else { return false }
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
//        self.summaryView?.reloadSummary(forDate: self.getCurrentDate())
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

}
