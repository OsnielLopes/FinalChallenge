//
//  WatchManager.swift
//  MiniChallenge3
//
//  Created by Erick Borges on 02/05/2018.
//  Copyright © 2018 Guilherme Paciulli. All rights reserved.
//

import WatchConnectivity

class WCSessionManager: NSObject, WCSessionDelegate {
    
    public static let shared = WCSessionManager()
    public var recievedMessage: (([String : Any]) -> Void)?
    
    override private init() {
        super.init()
        
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            if WCSession.default.activationState != .activated {
                WCSession.default.activate()
            }
        }
    }
    
    func isSupported() -> Bool {
        return false
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
    }
    
    // Recieve message
    public func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let recievedMessage = self.recievedMessage {
            recievedMessage(message)
        }
    }

    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        print("iOS recebeu")
    }
}
