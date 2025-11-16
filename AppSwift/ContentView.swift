import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            WelcomeView()
                .tabItem {
                    Label("Inicio", systemImage: "house")
                }
            ParityCheckView()
                .tabItem {
                    Label("Paridad", systemImage: "number")
                }
        }
    }
}

struct WelcomeView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Contextualización")
                        .font(.title2)
                        .bold()
                    Text("Swift es un lenguaje de programación moderno que brinda mayor seguridad y es intuitivo. Al dominarlo se pueden crear múltiples aplicaciones.")
                    Text("Esta app incluye un comprobador de números pares o impares. Dirígete a la pestaña 'Paridad' para ingresar un número y obtener la evaluación al instante.")
                }
                .padding()
            }
            .navigationTitle("App Swift")
        }
    }
}

struct RootTabView_Previews: PreviewProvider {
    static var previews: some View {
        RootTabView()
    }
}
