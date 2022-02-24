import SwiftUI
import Foundation
import WatchKit

@main
struct WatchApp : App {
    #if os(watchOS)
    @WKExtensionDelegateAdaptor(ConnectivityProvider.self) var delegate
    #endif
    init() {
        delegate.connect()
    }
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }
        #if os(watchOS)
        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
        #endif
    }
}
