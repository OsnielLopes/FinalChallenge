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
    var rangeMin: Double
    var rangeMax: Double
    var values: [EmotionChartPlot]
    var rangeValues: [MoodTypeRangeValues]
    
    init(chartTitle: String, moods: [MoodInput], possible moodTypes: [MoodType]) {
        
        // Setting up mood types to values
        self.chartTitle = chartTitle
        
        self.rangeValues = []
        var i: Double = 0.0
        for type in moodTypes {
            self.rangeValues.append(MoodTypeRangeValues(moodType: type, value: i))
            i += 1
        }
        self.rangeMin = self.rangeValues.first!.value
        self.rangeMax = self.rangeValues.last!.value
        
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
            let value = self.rangeValues.filter({ greatestValue == $0.moodType }).first!.value
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

struct MoodTypeRangeValues {
    let moodType: MoodType
    let value: Double
}
