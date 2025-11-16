import Foundation

final class AppSession: ObservableObject {
    @Published var isAuthenticated: Bool = false
}
