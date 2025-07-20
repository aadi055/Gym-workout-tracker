import SwiftUI
import Charts

struct VolumeBarChartView: View {
    let workouts: [Workout]

    var volumeData: [(date: Date, volume: Double)] {
        workouts.map { workout in
            let totalVolume = workout.exercises.reduce(0.0) { result, exercise in
                result + exercise.sets.reduce(0.0) { $0 + ($1.weight * Double($1.reps)) }
            }
            return (date: workout.date, volume: totalVolume)
        }.sorted(by: { $0.date < $1.date })
    }

    var body: some View {
        Chart {
            ForEach(volumeData, id: \.date) { entry in
                BarMark(
                    x: .value("Date", entry.date),
                    y: .value("Volume", entry.volume)
                )
            }
        }
        .frame(height: 200)
    }
}
