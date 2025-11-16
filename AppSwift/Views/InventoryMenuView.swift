import SwiftUI

struct InventoryMenuView: View {
    @State private var selectedOption: MenuOption? = nil
    @State private var articles: [Article] = []
    @State private var articleName: String = ""
    @State private var articleQuantity: String = ""
    @State private var menuInput: String = ""
    @State private var menuInputError: String = ""
    @State private var statusMessage: String = ""
    @State private var stockQuery: String = ""
    @State private var stockQueryResult: String = ""
    @State private var showStockQueryResult = false

    var body: some View {
        NavigationView {
            Form {
                menuSection

                if let option = selectedOption {
                    switch option {
                    case .register:
                        registerSection
                    case .list:
                        listSection
                    case .stock:
                        stockSection
                    case .exit:
                        exitSection
                    }
                }

                if !statusMessage.isEmpty {
                    statusSection
                }
            }
            .navigationTitle("Inventario")
        }
    }

    private var menuSection: some View {
        Section(header: Text("Menú principal")) {
            VStack(alignment: .leading, spacing: 4) {
                ForEach(MenuOption.allCases, id: \.self) { option in
                    Text("\(option.rawValue). \(option.menuText)")
                }
                Text("\nEscribe el número de la opción que deseas ejecutar y pulsa \"Aceptar\".")
            }
            .font(.system(.body, design: .monospaced))

            HStack {
                TextField("1 - 4", text: $menuInput)
                    .keyboardType(.numberPad)
                Button("Aceptar", action: evaluateMenuInput)
                    .buttonStyle(.borderedProminent)
            }

            if !menuInputError.isEmpty {
                Text(menuInputError)
                    .font(.footnote)
                    .foregroundColor(.red)
            }
        }
    }

    private var registerSection: some View {
        Section(header: Text("1. Registrar artículo")) {
            Text("Captura el nombre y la cantidad a guardar en inventario.")
                .font(.callout)
                .foregroundColor(.secondary)
            TextField("Nombre del producto", text: $articleName)
            TextField("Cantidad", text: $articleQuantity)
                .keyboardType(.numberPad)
            Button("Guardar artículo", action: registerArticle)
                .disabled(!canRegister)
        }
    }

    private var listSection: some View {
        Section(header: Text("2. Lista completa de artículos")) {
            if articles.isEmpty {
                Text("Aún no registras artículos.")
            } else {
                Text("Total de artículos registrados: \(articles.count)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                ForEach(articles) { article in
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Artículo \(article.number): \(article.name)")
                            .bold()
                        Text("Cantidad: \(article.quantity)")
                            .font(.footnote)
                            .foregroundColor(article.isInStock ? .primary : .orange)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
    }

    private var stockSection: some View {
        Section(header: Text("3. Consultar existencias")) {
            Text("Busca por nombre o por número para saber si hay unidades disponibles.")
                .font(.callout)
                .foregroundColor(.secondary)
            TextField("Ejemplo: 1 o Tornillos", text: $stockQuery)
            Button("Consultar", action: consultStock)
                .disabled(articles.isEmpty)

            if showStockQueryResult {
                Text(stockQueryResult)
                    .font(.body)
                    .foregroundColor(.primary)
            }

            Divider()

            let availableArticles = articles.filter { $0.isInStock }
            if availableArticles.isEmpty {
                Text("Aún no hay artículos con existencias.")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            } else {
                Text("Artículos con existencias:")
                    .font(.subheadline)
                ForEach(availableArticles) { article in
                    HStack {
                        Text(article.name)
                        Spacer()
                        Text("\(article.quantity) pzas")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }

    private var exitSection: some View {
        Section(header: Text("4. Salir")) {
            Text("Has salido del menú de inventario. Selecciona \"Reiniciar menú\" para volver a ejecutar otra opción.")
            Button("Reiniciar menú", action: resetMenu)
                .buttonStyle(.bordered)
        }
    }

    private var statusSection: some View {
        Section(header: Text("Estado")) {
            Text(statusMessage)
                .font(.body)
                .foregroundColor(.secondary)
        }
    }

    private var canRegister: Bool {
        let name = articleName.trimmingCharacters(in: .whitespacesAndNewlines)
        let quantity = articleQuantity.trimmingCharacters(in: .whitespacesAndNewlines)
        return !name.isEmpty && Int(quantity) != nil
    }

    private func evaluateMenuInput() {
        menuInputError = ""
        let trimmed = menuInput.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let value = Int(trimmed), let option = MenuOption(rawValue: value) else {
            menuInputError = "Selecciona un número válido entre 1 y 4."
            return
        }
        menuInput = ""
        handleSelection(option)
    }

    private func handleSelection(_ option: MenuOption) {
        withAnimation {
            selectedOption = option
        }

        switch option {
        case .register:
            statusMessage = "Ingresa los datos del artículo para almacenarlo."
        case .list:
            statusMessage = articles.isEmpty ? "Aún no hay artículos registrados." : "Lista actualizada de productos."
        case .stock:
            statusMessage = articles.isEmpty ? "No puedes consultar porque no hay artículos registrados." : "Usa el buscador para validar existencias."
        case .exit:
            statusMessage = "Has cerrado el menú de inventario."
            prepareExit()
        }
    }

    private func registerArticle() {
        let trimmedName = articleName.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedQuantity = articleQuantity.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let quantity = Int(trimmedQuantity), quantity >= 0 else {
            statusMessage = "Ingresa una cantidad válida."
            return
        }

        let newArticle = Article(number: (articles.last?.number ?? 0) + 1, name: trimmedName, quantity: quantity)
        articles.append(newArticle)
        articleName = ""
        articleQuantity = ""
        statusMessage = "Se registró \(newArticle.name) con \(newArticle.quantity) unidades."
    }

    private func consultStock() {
        showStockQueryResult = true
        let trimmedQuery = stockQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedQuery.isEmpty else {
            stockQueryResult = "Ingresa un criterio de búsqueda."
            return
        }

        let matches = articles.filter { article in
            article.name.localizedCaseInsensitiveContains(trimmedQuery) || String(article.number) == trimmedQuery
        }

        if let article = matches.first {
            if article.isInStock {
                stockQueryResult = "Hay \(article.quantity) unidades de \(article.name)."
            } else {
                stockQueryResult = "El artículo \(article.name) está agotado."
            }
        } else {
            stockQueryResult = "No se encontró un artículo que coincida con la búsqueda."
        }
    }

    private func prepareExit() {
        articleName = ""
        articleQuantity = ""
        stockQuery = ""
        stockQueryResult = ""
        showStockQueryResult = false
    }

    private func resetMenu() {
        selectedOption = nil
        statusMessage = ""
        menuInputError = ""
    }
}

private struct Article: Identifiable {
    let id = UUID()
    let number: Int
    let name: String
    let quantity: Int

    var isInStock: Bool { quantity > 0 }
}

private enum MenuOption: Int, CaseIterable {
    case register = 1
    case list
    case stock
    case exit

    var menuText: String {
        switch self {
        case .register:
            return "Registrar un artículo"
        case .list:
            return "Ver la lista de artículos"
        case .stock:
            return "Consultar los artículos en existencia"
        case .exit:
            return "Salir"
        }
    }
}

struct InventoryMenuView_Previews: PreviewProvider {
    static var previews: some View {
        InventoryMenuView()
    }
}
