import SwiftUI

@main
struct AppSwiftApp: App {
    @StateObject private var session = AppSession()
    
    var body: some Scene {
        WindowGroup {
            Group {
                if session.isAuthenticated {
                    RootTabView()
                } else {
                    LoginView()
                }
            }
            .environmentObject(session)
        }
    }
}
