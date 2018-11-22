//
//  InterfaceController.swift
//  Watch-App Extension
//
//  Created by Osniel Lopes Teixeira on 13/11/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import WatchKit
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    var selectedMood: MoodType!
    var messages: [[String: Any]] = [[:]]
    var session: WCSession!
    
    @IBOutlet weak var picker: WKInterfacePicker!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if WCSession.isSupported() {
            session = WCSession.default
            session.delegate = self
            session.activate()
            messages.append(["getMoods" : true])
        }
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func didSelect(_ value: Int) {
        
    }
    
    @IBAction func didTapSave() {
        
        self.presentAlert(withTitle: "Humor inserido com sucesso!", message: nil, preferredStyle: .alert, actions: [WKAlertAction(title: "Ok", style: .default, handler: {
            self.dismiss()
        })])
        print("Opa aqui a gente tem que implementar a rotina pra salvar o humor selecionado")
    }
    
    //MARK: - WCSessionDelegate
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        for message in messages {
            session.sendMessage(message, replyHandler: { (dict) in
                guard let moods = dict["moods"] as? [MoodType] else { fatalError("Impossible to get the moods from received dictionary")}
                var items: [MoodPickerItem] = []
                for mood in moods {
                    let item = MoodPickerItem()
                    item.contentImage = WKImage(imageName: mood.typeIcon!)
                    item.title = mood.typeText
                    items.append(item)
                }
                self.picker.setItems(items)
                self.picker.focus()
            }) { (error) in
                fatalError(error.localizedDescription)
            }
        }
        
    }
    
}
