//
//  EmotionsChartCell.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 07/11/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit
import ScrollableGraphView

class EmotionsChartCell: UITableViewCell, ScrollableGraphViewDataSource {
    
    // MARK: - IBOutlets
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var chartTitleLabel: UILabel!
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var segmentedControlShowOptions: UISegmentedControl!
    
    // MARK: - Properties
    var graphView: ScrollableGraphView?
    var data: EmotionChartDTO?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.cardView.layer.cornerRadius = self.cardView.frame.width / 30
        self.cardView.dropShadow(color: #colorLiteral(red: 0.01960784314, green: 0.06274509804, blue: 0.07843137255, alpha: 1), opacity: 0.25, offSet: CGSize(width: 0, height: 5), radius: 5, scale: true, shouldFollowPath: false)
        
    }
    
    func getSelectedDisplayOption() -> ChartDisplayOptions {
        switch self.segmentedControlShowOptions.selectedSegmentIndex {
        case 0:
            return .week
        case 1:
            return .month
        default:
            fatalError("Should update getSelectedDisplayOption function in EmotionsChartCell to comport new option")
        }
    }
    
    func setChart(forData data: EmotionChartDTO) {
        
        self.graphView?.removeFromSuperview()
        
        self.chartTitleLabel.text = data.chartTitle
        self.data = data
        
        self.graphView = ScrollableGraphView(frame: CGRect(origin: CGPoint.zero, size: self.chartView.frame.size))
        
        self.graphView?.dataSource = self
        
        self.graphView!.rangeMax = self.data!.rangeMax
        self.graphView!.rangeMin = self.data!.rangeMin
        self.graphView!.direction = .rightToLeft
        self.graphView!.contentOffset.x = self.graphView!.contentSize.width - self.graphView!.layer.frame.size.width
        self.graphView!.contentOffset.y = 0
        self.graphView!.leftmostPointPadding = 0
        self.graphView!.rightmostPointPadding = 20
        self.graphView!.shouldAnimateOnStartup = true
        
        let linePlot = LinePlot(identifier: "LinePlot")
        linePlot.lineStyle = .smooth
        linePlot.animationDuration = 0.5
        linePlot.adaptAnimationType = .easeOut
        
        let referenceLines = ReferenceLines()
        referenceLines.referenceLinePosition = .right
        referenceLines.shouldShowLabels = true
        referenceLines.positionType = .absolute
        referenceLines.includeMinMax = false
        
        self.graphView!.addPlot(plot: linePlot)
        self.graphView!.addReferenceLines(referenceLines: referenceLines)
        
        self.chartView!.addSubview(self.graphView!)
        
    }
    
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
        
        return self.data!.values[pointIndex].value
    }
    
    func label(atIndex pointIndex: Int) -> String {
        return self.data!.values[pointIndex].label
    }
    
    func numberOfPoints() -> Int {
        return self.data!.values.count
    }

}
