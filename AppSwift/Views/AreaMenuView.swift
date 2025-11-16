import SwiftUI

struct AreaMenuView: View {
    @State private var selectedOption: AreaOption? = nil
    @State private var menuInput: String = ""
    @State private var menuInputError: String = ""
    @State private var statusMessage: String = ""

    @State private var squareSide: String = ""
    @State private var squareArea: Double? = nil

    @State private var rectangleBase: String = ""
    @State private var rectangleHeight: String = ""
    @State private var rectangleArea: Double? = nil

    @State private var triangleBase: String = ""
    @State private var triangleHeight: String = ""
    @State private var triangleArea: Double? = nil

    @State private var circleRadius: String = ""
    @State private var circleArea: Double? = nil

    var body: some View {
        NavigationView {
            Form {
                menuSection

                if let option = selectedOption {
                    switch option {
                    case .square:
                        squareSection
                    case .rectangle:
                        rectangleSection
                    case .triangle:
                        triangleSection
                    case .circle:
                        circleSection
                    }
                }

                if !statusMessage.isEmpty {
                    statusSection
                }
            }
            .navigationTitle("Menú de áreas")
        }
    }

    private var menuSection: some View {
        Section(header: Text("Menú de áreas")) {
            VStack(alignment: .leading, spacing: 4) {
                ForEach(AreaOption.allCases, id: \.self) { option in
                    Text("\(option.rawValue)- \(option.menuText)")
                }
                Text("\nEscribe el número de la opción y pulsa \"Aceptar\" para continuar.")
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

    private var squareSection: some View {
        Section(header: Text("1- Área del cuadrado")) {
            Text("Introduce el valor del lado para calcular el área.")
                .font(.callout)
                .foregroundColor(.secondary)
            TextField("Valor del lado", text: $squareSide)
                .keyboardType(.decimalPad)
            Button("Calcular área", action: calculateSquareArea)
                .disabled(Double(squareSide) == nil)
            if let area = squareArea {
                Text(String(format: "El área del cuadrado es %.6f", area))
                    .font(.body)
            }
        }
    }

    private var rectangleSection: some View {
        Section(header: Text("2- Área del rectángulo")) {
            Text("Introduce la base y la altura del rectángulo.")
                .font(.callout)
                .foregroundColor(.secondary)
            TextField("Valor de la base", text: $rectangleBase)
                .keyboardType(.decimalPad)
            TextField("Valor de la altura", text: $rectangleHeight)
                .keyboardType(.decimalPad)
            Button("Calcular área", action: calculateRectangleArea)
                .disabled(Double(rectangleBase) == nil || Double(rectangleHeight) == nil)
            if let area = rectangleArea {
                Text(String(format: "El área del rectángulo es %.6f", area))
                    .font(.body)
            }
        }
    }

    private var triangleSection: some View {
        Section(header: Text("3- Área del triángulo")) {
            Text("Introduce la base y la altura del triángulo.")
                .font(.callout)
                .foregroundColor(.secondary)
            TextField("Valor de la base", text: $triangleBase)
                .keyboardType(.decimalPad)
            TextField("Valor de la altura", text: $triangleHeight)
                .keyboardType(.decimalPad)
            Button("Calcular área", action: calculateTriangleArea)
                .disabled(Double(triangleBase) == nil || Double(triangleHeight) == nil)
            if let area = triangleArea {
                Text(String(format: "El área del triángulo es %.6f", area))
                    .font(.body)
            }
        }
    }

    private var circleSection: some View {
        Section(header: Text("4- Área del círculo")) {
            Text("Introduce el valor del radio.")
                .font(.callout)
                .foregroundColor(.secondary)
            TextField("Valor del radio", text: $circleRadius)
                .keyboardType(.decimalPad)
            Button("Calcular área", action: calculateCircleArea)
                .disabled(Double(circleRadius) == nil)
            if let area = circleArea {
                Text(String(format: "El área del círculo es %.6f", area))
                    .font(.body)
            }
        }
    }

    private var statusSection: some View {
        Section(header: Text("Estado")) {
            Text(statusMessage)
                .font(.body)
                .foregroundColor(.secondary)
        }
    }

    private func evaluateMenuInput() {
        menuInputError = ""
        let trimmed = menuInput.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let value = Int(trimmed), let option = AreaOption(rawValue: value) else {
            menuInputError = "Ingresa un número válido entre 1 y 4."
            return
        }
        menuInput = ""
        handleSelection(option)
    }

    private func handleSelection(_ option: AreaOption) {
        withAnimation {
            selectedOption = option
        }

        switch option {
        case .square:
            statusMessage = "Elegiste el cuadrado. Captura el valor del lado."
        case .rectangle:
            statusMessage = "Elegiste el rectángulo. Captura base y altura."
        case .triangle:
            statusMessage = "Elegiste el triángulo. Captura base y altura."
        case .circle:
            statusMessage = "Elegiste el círculo. Captura el radio."
        }
    }

    private func calculateSquareArea() {
        guard let side = Double(squareSide) else { return }
        squareArea = side * side
    }

    private func calculateRectangleArea() {
        guard let base = Double(rectangleBase), let height = Double(rectangleHeight) else { return }
        rectangleArea = base * height
    }

    private func calculateTriangleArea() {
        guard let base = Double(triangleBase), let height = Double(triangleHeight) else { return }
        triangleArea = (base * height) / 2
    }

    private func calculateCircleArea() {
        guard let radius = Double(circleRadius) else { return }
        circleArea = Double.pi * radius * radius
    }
}

private enum AreaOption: Int, CaseIterable {
    case square = 1
    case rectangle
    case triangle
    case circle

    var menuText: String {
        switch self {
        case .square:
            return "Área del cuadrado"
        case .rectangle:
            return "Área del rectángulo"
        case .triangle:
            return "Área del triángulo"
        case .circle:
            return "Área del círculo"
        }
    }
}

struct AreaMenuView_Previews: PreviewProvider {
    static var previews: some View {
        AreaMenuView()
    }
}
