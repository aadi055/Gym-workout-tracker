import SwiftUI

struct WorkoutProgressView: View {
    @ObservedObject var workoutViewModel: WorkoutViewModel
    @ObservedObject var bodyWeightViewModel: BodyWeightViewModel

    @State private var selectedExercise = ""

    var allExerciseNames: [String] {
        let names = workoutViewModel.workouts.flatMap { $0.exercises.map { $0.name } }
        return Array(Set(names)).sorted()
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Workout Progress")
                    .font(.largeTitle.bold())

                // Exercise Line Chart Section
                Text("Exercise Progress Chart")
                    .font(.headline)

                Picker("Select Exercise", selection: $selectedExercise) {
                    ForEach(allExerciseNames, id: \.self) { name in
                        Text(name).tag(name)
                    }
                }
                .pickerStyle(.menu)
                .padding(.bottom, 8)

                if !selectedExercise.isEmpty {
                    ExerciseLineChartView(
                        workouts: workoutViewModel.workouts,
                        exerciseName: selectedExercise
                    )
                }

                // Volume Chart Section
                Text("Volume Per Session")
                    .font(.headline)

                VolumeBarChartView(workouts: workoutViewModel.workouts)

                // Bodyweight Logger Section
                Text("Bodyweight Tracker")
                    .font(.headline)

                BodyWeightLoggerView(viewModel: bodyWeightViewModel)
            }
            .padding()
        }
    }
}
