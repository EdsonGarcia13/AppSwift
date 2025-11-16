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
            InventoryMenuView()
                .tabItem {
                    Label("Inventario", systemImage: "list.number")
                }
            AreaMenuView()
                .tabItem {
                    Label("Áreas", systemImage: "square.grid.2x2")
                }
        }
    }
}

struct WelcomeView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Contextualización")
                        .font(.title2)
                        .bold()
                    Text("Swift es un lenguaje de programación moderno que brinda mayor seguridad y es intuitivo.\nAl dominarlo se pueden crear múltiples aplicaciones.")
                    Text("Esta app te guía a través de tres módulos con lógicas y menús propios: la pestaña 'Paridad' evalúa números pares o impares al instante, 'Inventario' permite registrar artículos y consultar sus existencias, y 'Áreas' calcula superficies geométricas como cuadrado, rectángulo, triángulo y círculo.")
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
