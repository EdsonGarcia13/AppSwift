import SwiftUI

struct ParityCheckView: View {
    @State private var numberText: String = ""
    @State private var evaluationMessage: String = ""
    @State private var showResult = false

    private let description = "Se necesita crear una aplicación donde sea posible ingresar un número y diga si es número par o impar."

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Criterio de aceptación")) {
                    Text(description)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }

                Section(header: Text("Ingresa un número")) {
                    TextField("Ejemplo: 42", text: $numberText)
                        .keyboardType(.numberPad)
                    Button(action: evaluateNumber) {
                        Label("Evaluar paridad", systemImage: "checkmark.circle")
                    }
                    .disabled(numberText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }

                if showResult {
                    Section(header: Text("Resultado")) {
                        Text(evaluationMessage)
                            .font(.headline)
                            .foregroundColor(.primary)
                    }
                }
            }
            .navigationTitle("Paridad")
        }
    }

    private func evaluateNumber() {
        let trimmed = numberText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let value = Int(trimmed) else {
            evaluationMessage = "Ingresa un número válido."
            showResult = true
            return
        }

        if value % 2 == 0 {
            evaluationMessage = "El número \(value) es par."
        } else {
            evaluationMessage = "El número \(value) es impar."
        }
        showResult = true
    }
}

struct ParityCheckView_Previews: PreviewProvider {
    static var previews: some View {
        ParityCheckView()
    }
}
