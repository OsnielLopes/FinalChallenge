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
    
    public var recievedMessage: (([String : Any]) -> Void)?
    private let session: WCSession? = WCSession.isSupported() ? WCSession.default : nil
    
    override private init() {
        super.init()
    }
    
    func startSession() {
        self.session?.delegate = self
        self.session?.activate()
    }
    
    // Recieve message
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let recievedMessage = self.recievedMessage {
            recievedMessage(message)
        }
    }
    
    // send message
    func sendMood(_ mood: String) {
        if WCSession.default.isReachable {
            let message = ["Mood": mood]
            WCSession.default.sendMessage(message, replyHandler: nil, errorHandler: nil)
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        print("watch recebeu")
    }
    
}
