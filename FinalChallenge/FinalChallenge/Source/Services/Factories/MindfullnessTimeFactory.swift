//
//  MindfullnessTimeFactory.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 16/11/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation
import HealthKit

class MindfullnessTimeFactory {
    
    static let shared = MindfullnessTimeFactory()
    
    private init() {}
    
    func generateMindfullnessTime(from: Date, to: Date, completion: @escaping (MindfullnessTimeDTO?, DataAccessError?) -> ()) {
        
        if to < from {
            fatalError()
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "dd/MM"
        
        var plots: [ChartPlot] = []
    
        HealthKitManager.shared.retrieveMindfullness(from: from, to: to, completion: { samp, err in
            guard let samples = samp, err == nil else {
                completion(MindfullnessTimeDTO(values: []), err)
                return
            }
            
            Dictionary(grouping: samples, by: { formatter.string(from: $0.startDate) }).forEach({ day, samples in
                let daySum = samples.filter({ Calendar.current.isDate($0.startDate, inSameDayAs: $0.endDate) }).map({ self.calculateTime(sample: $0) }).reduce(0, +)
                if daySum > 0 {
                    plots.append(ChartPlot(value: daySum, label: displayFormatter.string(from: samples[0].startDate), date: samples[0].startDate))
                }
            })
            completion(MindfullnessTimeDTO(values: plots), nil)
        })
    }
    
    private func calculateTime(sample: HKSample) -> TimeInterval {
        return sample.endDate.timeIntervalSince(sample.startDate)
    }
    
}
