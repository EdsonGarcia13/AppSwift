import Foundation

final class AppSession: ObservableObject {
    @Published var isAuthenticated: Bool

    init(isAuthenticated: Bool = false) {
        self.isAuthenticated = isAuthenticated
    }
}
