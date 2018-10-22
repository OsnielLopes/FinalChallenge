//
//  CalendarViewController.swift
//  FinalChallenge
//
//  Created by Osniel Lopes Teixeira on 02/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var weekdays: UIStackView!
    @IBOutlet weak var weekDaysTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var firstWeekdayLabelWidthConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    
    var previousMonthLabel: UILabel!
    var currentMonthLabel: UILabel!
    var nextMonthLabel: UILabel!
    
    var previousMonthLabelLeadingConstraint: NSLayoutConstraint!
    var currentMonthLabelLeadingConstraint: NSLayoutConstraint!
    var nextMonthLabelLeadingConstraint: NSLayoutConstraint!
    
    var previousMonthContainerView: UIView!
    var currentMonthContainerView: UIView!
    var nextMonthContainerView: UIView!
    
    var previousMonthContainerViewLeadingConstraint: NSLayoutConstraint!
    var currentMonthContainerViewLeadingConstraint: NSLayoutConstraint!
    var nextMonthContainerViewLeadingConstraint: NSLayoutConstraint!
    
    var previousMonthCollectionViewController: MonthCollectionViewController!
    var currentMonthCollectionViewController: MonthCollectionViewController!
    var nextMonthCollectionViewController: MonthCollectionViewController!
    
    var largeCalendarView = true
    var referenceDay = Date()
    var currentMonthLabelInitialFrame: CGRect!
    var originalMonthDays: [Date?] = []
    var currentMonthDays: [Date?] = []
    var calendar = Calendar(identifier: .gregorian)
    var summaryView: DailySummaryViewController?
    var horizontalTranslationLength: CGFloat = 0
    var distanceBetweenCurrentAndNextMonth: CGFloat = 0
    var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter
    }()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let safeAreaLayout = self.view.safeAreaLayoutGuide
        let firstDayOfTheWeekLabelExtraMargin = (firstWeekdayLabelWidthConstraint.constant/2)-weekdays.arrangedSubviews.first!.intrinsicContentSize.width/2
        
        currentMonthLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        currentMonthLabel.text = dateFormatter.string(from: referenceDay)
        currentMonthLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        self.view.addSubview(currentMonthLabel)
        currentMonthLabel.translatesAutoresizingMaskIntoConstraints = false
        currentMonthLabelLeadingConstraint = currentMonthLabel.leadingAnchor.constraint(equalTo: safeAreaLayout.leadingAnchor, constant: 30 + firstDayOfTheWeekLabelExtraMargin)
        currentMonthLabelLeadingConstraint.isActive = true
        currentMonthLabel.topAnchor.constraint(equalTo: safeAreaLayout.topAnchor, constant: 30).isActive = true
        
        nextMonthLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        nextMonthLabel.text = dateFormatter.string(from: calendar.date(byAdding: .month, value: 1, to: referenceDay)!)
        nextMonthLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        nextMonthLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        self.view.addSubview(nextMonthLabel)
        nextMonthLabel.translatesAutoresizingMaskIntoConstraints = false
        nextMonthLabelLeadingConstraint = nextMonthLabel.leadingAnchor.constraint(equalTo: safeAreaLayout.leadingAnchor, constant: self.view.frame.width-nextMonthLabel.intrinsicContentSize.width/2)
        nextMonthLabelLeadingConstraint.isActive = true
        nextMonthLabel.topAnchor.constraint(equalTo: safeAreaLayout.topAnchor, constant: 30).isActive = true
        
        previousMonthLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        previousMonthLabel.text = dateFormatter.string(from: calendar.date(byAdding: .month, value: -1, to: referenceDay)!)
        previousMonthLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        self.view.addSubview(previousMonthLabel)
        previousMonthLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceBetweenCurrentAndNextMonth = nextMonthLabelLeadingConstraint.constant - currentMonthLabelLeadingConstraint.constant
        previousMonthLabelLeadingConstraint = previousMonthLabel.leadingAnchor.constraint(equalTo: safeAreaLayout.leadingAnchor, constant:  -distanceBetweenCurrentAndNextMonth)
        previousMonthLabelLeadingConstraint.isActive = true
        previousMonthLabel.topAnchor.constraint(equalTo: safeAreaLayout.topAnchor, constant: 30).isActive = true
        
        firstWeekdayLabelWidthConstraint.constant = (self.view.frame.width - 60) / 7
        horizontalTranslationLength = self.view.frame.width-60
        
        // Configure and displays the month collection views
        
        previousMonthContainerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width-60, height: 0))
        self.view.addSubview(previousMonthContainerView)
        previousMonthContainerView.translatesAutoresizingMaskIntoConstraints = false
        previousMonthContainerView.topAnchor.constraint(equalTo: weekdays.bottomAnchor, constant:  8).isActive = true
        previousMonthContainerViewLeadingConstraint = previousMonthContainerView.leadingAnchor.constraint(equalTo: safeAreaLayout.leadingAnchor, constant: 30-self.view.frame.width)
        previousMonthContainerViewLeadingConstraint.isActive = true
        previousMonthContainerView.bottomAnchor.constraint(equalTo: safeAreaLayout.bottomAnchor, constant: 0).isActive = true
        previousMonthContainerView.widthAnchor.constraint(equalToConstant: self.view.frame.width-60).isActive = true
        
        previousMonthCollectionViewController = MonthCollectionViewController(collectionViewLayout: CalendarUICollectionViewFlowLayout())
        previousMonthCollectionViewController.currentMonthDays = self.currentMonthDays
        previousMonthCollectionViewController.originalMonthDays = self.originalMonthDays
        previousMonthCollectionViewController.cellWidth = (firstWeekdayLabelWidthConstraint.constant)-0.00001
        previousMonthCollectionViewController.referenceDay = calendar.date(byAdding: .month, value: -1, to: referenceDay)!
        previousMonthCollectionViewController.collectionView.reloadData()
        self.addChild(previousMonthCollectionViewController)
        previousMonthCollectionViewController.view.frame = CGRect(origin: CGPoint.zero, size: previousMonthContainerView.frame.size)
        self.previousMonthContainerView.addSubview(previousMonthCollectionViewController.view)
        previousMonthCollectionViewController.didMove(toParent: self)
        
        currentMonthContainerView = UIView(frame: CGRect(x: 10, y: 10, width: self.view.frame.width-60, height: 100))
        self.view.addSubview(currentMonthContainerView)
        currentMonthContainerView.translatesAutoresizingMaskIntoConstraints = false
        currentMonthContainerView.topAnchor.constraint(equalTo: weekdays.bottomAnchor, constant:  8).isActive = true
        currentMonthContainerViewLeadingConstraint = currentMonthContainerView.leadingAnchor.constraint(equalTo: safeAreaLayout.leadingAnchor, constant: 30)
        currentMonthContainerViewLeadingConstraint.isActive = true
        currentMonthContainerView.bottomAnchor.constraint(equalTo: safeAreaLayout.bottomAnchor, constant: 0).isActive = true
        currentMonthContainerView.widthAnchor.constraint(equalToConstant: self.view.frame.width-60).isActive = true
        
        currentMonthCollectionViewController = MonthCollectionViewController(collectionViewLayout: CalendarUICollectionViewFlowLayout())
        currentMonthCollectionViewController.currentMonthDays = self.currentMonthDays
        currentMonthCollectionViewController.originalMonthDays = self.originalMonthDays
        currentMonthCollectionViewController.cellWidth = (firstWeekdayLabelWidthConstraint.constant)-0.00001
        currentMonthCollectionViewController.collectionView.reloadData()
        self.addChild(currentMonthCollectionViewController)
        currentMonthCollectionViewController.view.frame = CGRect(origin: CGPoint.zero, size: currentMonthContainerView.frame.size)
        self.currentMonthContainerView.addSubview(currentMonthCollectionViewController.view)
        currentMonthCollectionViewController.didMove(toParent: self)
    

    }
    
    //MARK: - IBActions
    
    @IBAction func changeTheCalendarStatus() {
        
        return
        
        let weekOfCurrentDay = calendar.component(.weekOfMonth, from: (currentMonthCollectionViewController.collectionView.cellForItem(at: currentMonthCollectionViewController.collectionView.indexPathsForSelectedItems!.first!) as! CalendarCollectionViewCell).day)
        (currentMonthCollectionViewController.collectionViewLayout as! CalendarUICollectionViewFlowLayout).expanding = !largeCalendarView
        
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
            
            for indexPath in currentMonthCollectionViewController.collectionView.indexPathsForSelectedItems! {
                if indexPathOfItemsToBeRemoved.contains(indexPath) {
                    fatalError("Trying to remove a selected item.")
                }
            }
            
            indexOfItemsToBeRemoved.reverse()
            for index in indexOfItemsToBeRemoved {
                currentMonthDays.remove(at: index)
            }

            (currentMonthCollectionViewController.collectionViewLayout as! CalendarUICollectionViewFlowLayout).weekOfCurrentDay = weekOfCurrentDay
            
            UIView.animate(withDuration: 1) {
                self.currentMonthLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                self.nextMonthLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                self.nextMonthLabel.alpha = 0
                self.weekDaysTopConstraint.constant -= self.currentMonthLabelInitialFrame.height/2
                self.view.layoutIfNeeded()
                self.currentMonthCollectionViewController.collectionView.deleteItems(at: indexPathOfItemsToBeRemoved)
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
                self.currentMonthCollectionViewController.collectionView.insertItems(at: indexPathOfItemsToBeAdded)
                
            }
            //            currentMonth.insertItems(at: [IndexPath(row: 0, section: 0)])
        }
        
        largeCalendarView = !largeCalendarView
    }
    
    // Animation Variables
    var changingMonthAnimation: UIViewPropertyAnimator!
    
    @IBAction func handlePan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)
        let horizontalPan = abs(Double(translation.x))
        // let percentageComplete = CGFloat((verticalPan - startPoint) / swipeLength) usar um valor definido para startPoint impediria o usuário de começar uma transição não solicitada
        let percentageComplete = CGFloat(horizontalPan/Double(horizontalTranslationLength))
        switch sender.state {
        case .began:
            changingMonthAnimation = UIViewPropertyAnimator(duration: 1, curve: .linear, animations: {
                self.previousMonthLabelLeadingConstraint.constant = self.currentMonthLabelLeadingConstraint.constant
                self.currentMonthLabelLeadingConstraint.constant = self.view.frame.width - self.currentMonthLabel.intrinsicContentSize.width/2
                self.currentMonthLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                self.nextMonthLabelLeadingConstraint.constant += self.view.frame.width
                self.previousMonthContainerViewLeadingConstraint.constant += self.view.frame.width
                self.currentMonthContainerViewLeadingConstraint.constant += self.view.frame.width
                self.view.layoutIfNeeded()
            })
            changingMonthAnimation.addCompletion { (animationPosition) in
                
                self.referenceDay = self.calendar.date(byAdding: .month, value: -1, to: self.referenceDay)!
                
                let placeholderLabel = self.nextMonthLabel
                self.nextMonthLabel = self.currentMonthLabel
                self.currentMonthLabel = self.previousMonthLabel
                self.previousMonthLabel = placeholderLabel
                self.previousMonthLabel.textColor = UIColor.black
                self.previousMonthLabel.text = self.dateFormatter.string(from: self.calendar.date(byAdding: .month, value: -1, to: self.referenceDay)!)
                
                let placeholderConstraint = self.nextMonthLabelLeadingConstraint
                self.nextMonthLabelLeadingConstraint = self.currentMonthLabelLeadingConstraint
                self.currentMonthLabelLeadingConstraint = self.previousMonthLabelLeadingConstraint
                self.previousMonthLabelLeadingConstraint = placeholderConstraint
                self.previousMonthLabelLeadingConstraint.constant = -self.distanceBetweenCurrentAndNextMonth
                
                let placeholderCollectionView = self.currentMonthContainerView
                self.currentMonthContainerView = self.previousMonthContainerView
                self.previousMonthContainerView = placeholderCollectionView
                
                self.currentMonthCollectionViewController.referenceDay = self.calendar.date(byAdding: .month, value: -1, to: self.referenceDay)!
                self.previousMonthCollectionViewController.viewDidLoad()
                self.currentMonthContainerViewLeadingConstraint.constant -= self.view.frame.width*2
                
            }
            changingMonthAnimation.pauseAnimation()
        case .changed:
            DispatchQueue.main.async {
                self.changingMonthAnimation.fractionComplete = percentageComplete
            }
            
        
        case .ended, .cancelled:
            if percentageComplete > 0.3 {
                changingMonthAnimation.continueAnimation(withTimingParameters: nil, durationFactor: 0)
            }
            
        default:
            break
        }
       
    }
    
     // MARK: - Auxiliar Functions
    func getCurrentDate() -> Date {
        let currentDay = (currentMonthCollectionViewController.collectionView.cellForItem(at: (currentMonthCollectionViewController.collectionView.indexPathsForSelectedItems?.first)!) as! CalendarCollectionViewCell).day
        return currentDay!
    }
 
    
    
    
}
