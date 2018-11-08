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
    
    // MARK: - Properties
    var graphView: ScrollableGraphView!
    var values: [EmotionChartViewObject] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.cardView.layer.cornerRadius = self.cardView.frame.width / 30
        self.cardView.dropShadow(color: #colorLiteral(red: 0.01960784314, green: 0.06274509804, blue: 0.07843137255, alpha: 1), opacity: 0.25, offSet: CGSize(width: 0, height: 5), radius: 5, scale: true, shouldFollowPath: false)
        
        self.graphView = ScrollableGraphView(frame: self.chartView.frame)
        
        let linePlot = LinePlot(identifier: "LinePlot")
        linePlot.lineStyle_ = ScrollableGraphViewLineStyle.straight.rawValue
        
        let referenceLines = ReferenceLines()
        referenceLines.referenceLinePosition = .right
        
        self.graphView.addPlot(plot: linePlot)
        self.graphView.addReferenceLines(referenceLines: referenceLines)
        
        self.graphView.rightmostPointPadding = 0.0
        self.chartView.addSubview(self.graphView)
        
    }
    
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
        return self.values[pointIndex].value
    }
    
    func label(atIndex pointIndex: Int) -> String {
        return self.values[pointIndex].time
    }
    
    func numberOfPoints() -> Int {
        return self.values.count
    }

}
