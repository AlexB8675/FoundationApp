
import Foundation
import WatchConnectivity
import Combine
import UserNotifications
#if os(watchOS)
import WatchKit
#endif

class ConnectivityProvider: NSObject, WCSessionDelegate {
    private let session: WCSession
    
    override init() {
        self.session = .default
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
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
    
    func session(_ session: WCSession, didReceiveMessage: [String : Any]) {
        let content = UNMutableNotificationContent()
        content.title = "App"
        content.body = "Test"
        content.interruptionLevel = .critical
        content.categoryIdentifier = "myCategory"
        #if os(watchOS)
        UNUserNotificationCenter.current().add(UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)) {
            e in if let error = e {
                print(error)
                return
            }
        }
        #endif
        print("Sent message")
    }

    
    func sendMessage(message: [String : Any]) {
        session.sendMessage(message, replyHandler: nil) {
            e in print(e)
        }
    }
    
#if os(iOS)
    func sessionWatchStateDidChange(_ session: WCSession) {
        print(#function)
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print(#function)
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print(#function)
    }
#endif
}

#if os(watchOS)
extension ConnectivityProvider : WKExtensionDelegate {
    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        for task in backgroundTasks {
            task.setTaskCompletedWithSnapshot(true)
        }
    }
    
    func applicationDidEnterBackground() {
        print("sos")
    }
}
#endif
