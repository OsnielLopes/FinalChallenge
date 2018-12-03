//
//  WatchManager.swift
//  MiniChallenge3
//
//  Created by Erick Borges on 02/05/2018.
//  Copyright © 2018 Guilherme Paciulli. All rights reserved.
//

import WatchConnectivity

class WSManager: NSObject, WCSessionDelegate {
    
    public static let shared = WSManager()
    private var validSession: WCSession?

    override private init() {
        super.init()
    }
    
    func startSession() {
        if WCSession.isSupported() {
            self.validSession = WCSession.default
            self.validSession?.delegate = self
            self.validSession?.activate()
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
    }
    
    // Recieve message
    public func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if message.keys.contains("Mood") {
            let moodString = message["Mood"] as! String
            MoodDAO.shared.fetchAll { (moods, error) -> (Void) in
                guard let moods = moods else { return }
                let mood = moods.first(where: { (mood) -> Bool in
                    return mood.moodType?.typeIcon == moodString
                })
                guard let moodType = mood?.moodType else { return }
                MoodDAO.shared.insertMood(moodType: moodType, date: Date(), completion: { (mood, error) -> (Void) in
                    guard error != nil else { return }
                    print("TODO: enviar mensagem para o NotificationCenter avisando que o mood foi criado")
                })
            }
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("WatchConnectivity ")
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        print("iOS recebeu")
    }
}
