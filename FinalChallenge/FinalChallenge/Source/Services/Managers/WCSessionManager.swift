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
    private var validSession: WCSession? /*{

        // paired - the user has to have their device paired to the watch
        // watchAppInstalled - the user must have your watch app installed

        // Note: if the device is paired, but your watch app is not installed
        // consider prompting the user to install it for a better experience

        if let session = self.session, (session.isPaired && session.isWatchAppInstalled) {
            return session
        }
        return nil
    }*/
//    private let session: WCSession? = WCSession.isSupported() ? WCSession.default : nil

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
        if let recievedMessage = self.recievedMessage {
            recievedMessage(message)
            print(message)
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("olá")
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        print("iOS recebeu")
    }
}
