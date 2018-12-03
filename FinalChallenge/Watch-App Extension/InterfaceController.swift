//
//  InterfaceController.swift
//  Watch-App Extension
//
//  Created by Osniel Lopes Teixeira on 13/11/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import WatchKit
import WatchConnectivity

class InterfaceController: WKInterfaceController {
    
    var selectedMoodIndex: Int = 0
    var session: WCSession!

    @IBOutlet weak var picker: WKInterfacePicker!

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        var pickerItems: [WKPickerItem] = []
        for i in 1...5 {
            let item = WKPickerItem()
            item.contentImage = WKImage(imageName: "mood\(i)-icon")
            pickerItems.append(item)
        }
        picker.setItems(pickerItems)
        picker.focus()
        
        WSManager.shared.startSession()
    }

    //MARK - IBActionss
    @IBAction func didSelect(_ value: Int) {
        selectedMoodIndex = value
    }

    @IBAction func didTapSave() {
        WSManager.shared.sendMood("mood\(self.selectedMoodIndex+1)-icon")
    }


    
}
