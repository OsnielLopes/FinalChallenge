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
    var values: [MindfullnessTimeChartPlot]
    
    init(values: [MindfullnessTimeChartPlot]) {
        self.chartTitle = "Mindfullness Time"
        self.values = values
    }
    
}

struct MindfullnessTimeChartPlot {
    var value: Double
    var label: String
    var date: Date
}
