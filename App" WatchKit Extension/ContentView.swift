import SwiftUI
import WatchKit
import UserNotifications

func schedule_refresh() {
    WKExtension.shared().scheduleBackgroundRefresh(withPreferredDate: .now, userInfo: nil) {
        e in if let error = e {
            print(error)
        }
        print("mario")
        DispatchQueue.main.asyncAfter(deadline: .now() + 15.0) {
            schedule_refresh()
        }
    }
}

struct ContentView: View {
    public var text: String
    private var delegate = NotificationDelegate()
    
    init(text: String) {
        self.text = text
        schedule_refresh()
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge]) {
            (s, e) in if let error = e {
                print(error)
            }
        }
    }
    
    var body: some View {
        Text(text)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(text: "text")
    }
}
