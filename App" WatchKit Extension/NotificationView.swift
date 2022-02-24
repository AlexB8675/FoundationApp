import SwiftUI

struct NotificationView: View {
    var msg: String
    
    var body: some View {
        Text(msg).padding()
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView(msg: "Test")
    }
}
