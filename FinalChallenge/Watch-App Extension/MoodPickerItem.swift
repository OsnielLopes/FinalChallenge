//
//  MoodPickerItem.swift
//  FinalChallenge
//
//  Created by Osniel Lopes Teixeira on 21/11/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation
import WatchKit

class MoodPickerItem: WKPickerItem {
    
    init(mood: MoodType) {
        super.init()
        self.title = mood.typeText
        self.contentImage = WKImage(imageName: mood.typeIcon!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
