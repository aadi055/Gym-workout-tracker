import SwiftUI
import Charts

struct ExerciseLineChartView: View {
    let workouts: [Workout]
    let exerciseName: String

    var exerciseProgressData: [(date: Date, weight: Double)] {
        workouts.compactMap { workout in
            guard let exercise = workout.exercises.first(where: { $0.name == exerciseName }),
                  let maxSet = exercise.sets.max(by: { $0.weight < $1.weight }) else {
                return nil
            }
            return (date: workout.date, weight: maxSet.weight)
        }.sorted(by: { $0.date < $1.date })
    }

    var body: some View {
        Chart {
            ForEach(exerciseProgressData, id: \.date) { entry in
                LineMark(
                    x: .value("Date", entry.date),
                    y: .value("Max Weight", entry.weight)
                )
                .interpolationMethod(.monotone)
            }
        }
        .frame(height: 200)
    }
}
