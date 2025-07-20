// MARK: - BodyWeightEntry.swift

import Foundation

struct BodyWeightEntry: Identifiable, Codable {
    var id = UUID()
    var date: Date
    var weight: Double
}


// MARK: - BodyWeightViewModel.swift

import Foundation
import SwiftUI

class BodyWeightViewModel: ObservableObject {
    @Published var weightEntries: [BodyWeightEntry] = []
    
    func addEntry(date: Date, weight: Double) {
        let entry = BodyWeightEntry(date: date, weight: weight)
        weightEntries.append(entry)
        weightEntries.sort { $0.date < $1.date }
    }
}
