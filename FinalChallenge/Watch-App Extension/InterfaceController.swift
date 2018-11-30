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
    
    var selectedMoodIndex: Int!
    var moods: [MoodType]! {
        didSet {
            self.picker.setItems(moods.map({ (mood) -> MoodPickerItem in
                return MoodPickerItem(mood: mood)
            }))
        }
    }
    var session: WCSession = WCSession.default
    var messagesToSent: [Int] = []
    
    @IBOutlet weak var picker: WKInterfacePicker!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    //MARK - IBActions
    
    @IBAction func didSelect(_ value: Int) {
        selectedMoodIndex = value
    }
    
    @IBAction func didTapSave() {
        WSManager.shared.sendMood(selectedMoodIndex)
    }


    
}
