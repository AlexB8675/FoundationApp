//
//  App_App.swift
//  App" WatchKit Extension
//
//  Created by Sara Izzo on 16/02/22.
//

import SwiftUI

@main
struct App_App: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
