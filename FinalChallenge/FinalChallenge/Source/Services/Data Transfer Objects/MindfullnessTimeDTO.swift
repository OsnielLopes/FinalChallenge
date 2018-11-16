//
//  MindfullnessTimeDTO.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 08/11/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

class MindfullnessTimeDTO {
    
    var chartTitle: String
    var rangeMin: Double
    var rangeMax: Double
    var values: [MindfullnessTimeChartPlot]
    var rangeValues: [MindfullnessTimeRangeValues]
    
    init(rangeMin: Double, rangeMax: Double, values: [MindfullnessTimeChartPlot], rangeValues: [MindfullnessTimeRangeValues]) {
        self.chartTitle = "Mindfullness Time"
        self.rangeMin = rangeMin
        self.rangeMax = rangeMax
        self.values = values
        self.rangeValues = rangeValues
    }
    
}

struct MindfullnessTimeChartPlot {
}

struct MindfullnessTimeRangeValues {
}
