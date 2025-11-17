import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var session: AppSession
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var statusMessage: String = ""
    @State private var isError: Bool = false
    
    private let validCredential = "test123"
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                VStack(spacing: 8) {
                    Text("Bienvenido")
                        .font(.largeTitle.bold())
                    Text("Ingresa con las credenciales de prueba para acceder al aplicativo.")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 32)
                
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Usuario")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        TextField("test123", text: $username)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .textFieldStyle(.roundedBorder)
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Contraseña")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        SecureField("••••••", text: $password)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .textFieldStyle(.roundedBorder)
                    }

                    Text("Credenciales de prueba: test123 / test123")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
                
                Button(action: authenticate) {
                    Text("Iniciar sesión")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.horizontal)
                
                if !statusMessage.isEmpty {
                    Text(statusMessage)
                        .foregroundColor(isError ? .red : .green)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                Spacer()
            }
            .padding(.bottom, 32)
            .navigationTitle("Inicio de sesión")
        }
    }
    
    private func authenticate() {
        guard !username.isEmpty, !password.isEmpty else {
            statusMessage = "Completa usuario y contraseña para continuar."
            isError = true
            return
        }
        
        if username == validCredential && password == validCredential {
            statusMessage = "Acceso concedido."
            isError = false
            withAnimation {
                session.isAuthenticated = true
            }
        } else {
            statusMessage = "Credenciales inválidas. Inténtalo nuevamente."
            isError = true
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(AppSession())
}
