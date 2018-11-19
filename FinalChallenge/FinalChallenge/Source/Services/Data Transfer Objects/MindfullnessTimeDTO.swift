//
//  MindfullnessTimeDTO.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 08/11/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

class MindfullnessTimeDTO: ChartDTO {
    
    
    init(values: [ChartPlot]) {
        let valuesDouble = values.map({ $0.value })
        super.init(chartTitle: "Mindfullness Time", rangeMin: valuesDouble.max() ?? 0, rangeMax: 1, plots: values)
    }
    
}
