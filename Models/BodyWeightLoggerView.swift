// MARK: - BodyWeightLoggerView.swift

import SwiftUI
import Charts

struct BodyWeightLoggerView: View {
    @ObservedObject var viewModel: BodyWeightViewModel
    @State private var selectedDate = Date()
    @State private var weightText = ""

    var body: some View {
        VStack(alignment: .leading) {
            Text("Log Bodyweight")
                .font(.headline)

            HStack {
                DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                TextField("Weight", text: $weightText)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)
                Button("Add") {
                    if let weight = Double(weightText) {
                        viewModel.addEntry(date: selectedDate, weight: weight)
                        weightText = ""
                    }
                }
            }

            Text("Progress Chart")
                .font(.headline)

            Chart(viewModel.weightEntries) { entry in
                LineMark(
                    x: .value("Date", entry.date),
                    y: .value("Weight", entry.weight)
                )
            }
            .frame(height: 200)
        }
        .padding()
    }
}

