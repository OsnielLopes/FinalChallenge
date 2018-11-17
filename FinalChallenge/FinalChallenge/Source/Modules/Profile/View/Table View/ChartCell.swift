//
//  EmotionsChartCell.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 07/11/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

class ChartCell: UITableViewCell, ScrollableGraphViewDataSource {
    
    // MARK: - IBOutlets
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var chartTitleLabel: UILabel!
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var segmentedControlShowOptions: UISegmentedControl!
    
    // MARK: - Properties
    var graphView: ScrollableGraphView?
    var data: ChartDTO?
    var profileView: ProfileView!
    
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
    
    // MARK: - FIXME
    func setChart(forData data: ChartDTO) {
        self.graphView?.removeFromSuperview()
        
        self.chartTitleLabel.text = data.chartTitle
        self.data = data
        
        self.graphView = ScrollableGraphView(frame: CGRect(origin: CGPoint.zero, size: self.chartView.frame.size))
        
        self.graphView?.dataSource = self
        
        self.graphView!.direction = .rightToLeft
        self.graphView!.contentOffset.x = self.graphView!.contentSize.width - self.graphView!.layer.frame.size.width
        self.graphView!.contentOffset.y = 0
        self.graphView!.leftmostPointPadding = 25
        self.graphView!.rightmostPointPadding = 50
        self.graphView!.shouldAnimateOnStartup = false
        self.graphView!.dataPointSpacing = 60
        self.graphView!.rangeMax = self.data!.rangeMax
        self.graphView!.rangeMin = self.data!.rangeMin
        
        if let emotionData = data as? EmotionChartDTO {
            self.setChart(forData: emotionData)
        } else if let mindfullnessData = data as? MindfullnessTimeDTO {
            self.setChart(for: mindfullnessData)
        }
        
        self.chartView!.addSubview(self.graphView!)
    }
    
    // MARK: - FIXME
    private func setChart(forData data: EmotionChartDTO) {
        
        let linePlot = LinePlot(identifier: "LinePlot")
        linePlot.lineStyle = .smooth
        linePlot.animationDuration = 0.5
        linePlot.adaptAnimationType = .easeOut
        linePlot.lineColor = #colorLiteral(red: 0.1843137255, green: 0.6588235294, blue: 0.831372549, alpha: 1)
        
        let referenceLines = ReferenceLines()
        referenceLines.referenceLinePosition = .right
        referenceLines.referenceLineColor = #colorLiteral(red: 0.6274509804, green: 0.8431372549, blue: 0.9215686275, alpha: 1)
        referenceLines.dataPointLabelFont = UIFont.italicSystemFont(ofSize: 10)
        referenceLines.sizeForImage = {
            return CGSize(width: 20, height: 20)
        }
        referenceLines.imageViewForLabelTag = { tag in
            let moodType = data.rangeValues.first(where: { $0.value == Double(tag)! })!
            
            let imageView = UIImageView(image: UIImage(named: moodType.moodType.typeIcon!)!)
            imageView.backgroundColor = #colorLiteral(red: 0.1843137255, green: 0.6588235294, blue: 0.831372549, alpha: 1)
            imageView.contentMode = .scaleAspectFit
            imageView.layer.cornerRadius = 10
            imageView.clipsToBounds = true
            
            return imageView
        }
        
        self.graphView!.addReferenceLines(referenceLines: referenceLines)
        self.graphView!.addPlot(plot: linePlot)

    }
    
    // MARK: - FIXME
    private func setChart(for data: MindfullnessTimeDTO) {
        let linePlot = LinePlot(identifier: "LinePlot")
        linePlot.lineStyle = .smooth
        linePlot.animationDuration = 0.5
        linePlot.adaptAnimationType = .easeOut
        linePlot.lineColor = #colorLiteral(red: 0.1843137255, green: 0.6588235294, blue: 0.831372549, alpha: 1)
        
        let referenceLines = ReferenceLines()
        referenceLines.referenceLinePosition = .right
        referenceLines.referenceLineColor = #colorLiteral(red: 0.6274509804, green: 0.8431372549, blue: 0.9215686275, alpha: 1)
        referenceLines.dataPointLabelFont = UIFont.italicSystemFont(ofSize: 10)
        
        self.graphView!.addReferenceLines(referenceLines: referenceLines)
        self.graphView!.addPlot(plot: linePlot)
    }
    
    // MARK: - FIXME
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
        return self.data!.values[pointIndex].value
    }
    
    // MARK: - FIXME
    func label(atIndex pointIndex: Int) -> String {
        return self.data!.values[pointIndex].label
    }
    
    // MARK: - FIXME
    func numberOfPoints() -> Int {
        return self.data!.values.count
    }
    @IBAction func didChangeSegmentControl(_ sender: UISegmentedControl) {
        self.profileView.fetchInputedEmotions(with: self.getSelectedDisplayOption())
    }
    
}
