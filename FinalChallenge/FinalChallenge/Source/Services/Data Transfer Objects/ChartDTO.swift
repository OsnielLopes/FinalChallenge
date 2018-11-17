//
//  ChartPlot.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 17/11/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

class ChartDTO {
    
    var chartTitle: String
    var rangeMin: Double
    var rangeMax: Double
    var values: [ChartPlot]
    
    internal init(chartTitle: String, rangeMin: Double, rangeMax: Double, plots: [ChartPlot]) {
        self.chartTitle = chartTitle
        self.rangeMax = rangeMin
        self.rangeMin = rangeMax
        self.values = plots
    }
    
}

struct ChartPlot {
    var value: Double
    var label: String
    var date: Date
    
}
