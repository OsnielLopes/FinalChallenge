//
//  EmotionChartDTO.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 08/11/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

class EmotionChartDTO {
    
    var chartTitle: String
    var values: [EmotionChartPlot]
    var moodTypeValues: [MoodTypeValues]
    var rangeMin: Double
    var rangeMax: Double
    
    init(chartTitle: String, moods: [MoodInput], possible moodTypes: [MoodType]) {
        
        // Setting up mood types to values
        self.chartTitle = chartTitle
        
        self.moodTypeValues = []
        var i: Double = 0.0
        for type in moodTypes {
            self.moodTypeValues.append(MoodTypeValues(moodType: type, value: i))
            i += 1
        }
        self.rangeMin = self.moodTypeValues.first!.value
        self.rangeMax = self.moodTypeValues.last!.value
        
        let cal = Calendar.current
        let moodInputs = Dictionary.init(grouping: moods, by: { cal.startOfDay(for: $0.date! as Date)})
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        
        self.values = []
        moodInputs.forEach({ k, v in
            
            // Finding the fashion
            let moodsForMoodType = Dictionary(grouping: v, by: { $0.moodType! })
            var greatestValue: MoodType?
            var greatesTimesAppeared = -1
            moodsForMoodType.forEach({ type, moods in
                if greatesTimesAppeared < moods.count {
                    greatesTimesAppeared = moods.count
                    greatestValue = type
                }
            })
            
            // Instantiating the value
            let value = self.moodTypeValues.filter({ greatestValue == $0.moodType }).first!.value
            let dateString = formatter.string(from: v[0].date! as Date)
            self.values.append(EmotionChartPlot(value: value, label: dateString, date: v[0].date! as Date))
        })
        
        self.values.sort(by: { $0.date <= $1.date })
        
    }
    
}

struct EmotionChartPlot {
    var value: Double
    var label: String
    var date: Date
}

struct MoodTypeValues {
    let moodType: MoodType
    let value: Double
}
