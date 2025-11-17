import SwiftUI

@main
struct AppSwiftApp: App {
    @StateObject private var session: AppSession

    init() {
        #if DEBUG
        _session = StateObject(wrappedValue: AppSession(isAuthenticated: true))
        #else
        _session = StateObject(wrappedValue: AppSession())
        #endif
    }
    
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
