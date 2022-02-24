import Foundation
import UserNotifications

class NotificationDelegate : NSObject, UNUserNotificationCenterDelegate {
    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
    
    // Viene chiamata se l'app è in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("Foregound: \(notification)")
        completionHandler([.badge])
    }
    
    // Viene chiamata se l'app è in background
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Background: \(response.notification.request.content.body)")
        completionHandler()
    }
}
