//
//  NotificationController.swift
//  SignalKWatchApp WatchKit Extension
//
//  Created by Emanuel Di Nardo on 01/02/22.
//

import WatchKit
import SwiftUI
import UserNotifications
import Foundation
import Combine

class NotificationController: WKUserNotificationHostingController<NotificationView> {
    
    override init() {
        
    }
    
    override var body: NotificationView {
        return NotificationView(msg: "")
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    override func didReceive(_ notification: UNNotification) {
        
    }
}
