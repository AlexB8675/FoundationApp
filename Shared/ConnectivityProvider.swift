//
//  ConnectivityProvider.swift
//  SignalKApp
//
//  Created by Emanuel Di Nardo on 01/02/22.
//

import Foundation
import WatchConnectivity
import Combine
import UserNotifications


class ConnectivityProvider: NSObject, WCSessionDelegate {
    private let session: WCSession
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
    }
    
    func connect() {
        guard WCSession.isSupported() else {
            print("WCSession is not supported")
            return
        }
        
        session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sendMessage(message: [String: Any]) {
        session.sendMessage(message, replyHandler: nil, errorHandler: {
            error in print(error.localizedDescription)
        })
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        let content = UNMutableNotificationContent()
        content.body = "pino"
        #if os(watchOS)
        UNUserNotificationCenter.current().add(UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)) {
            e in if let error = e {
                print(error)
            }
            print("Request added")
        }
        print("Connectivity: \(message)")
        #endif
    }
    
#if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {
        print(#function)
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print(#function)
    }
#endif
}

let connectivity = ConnectivityProvider()
