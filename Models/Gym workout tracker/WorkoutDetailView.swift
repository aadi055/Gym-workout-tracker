import SwiftUI

struct WorkoutDetailView: View {
    let workout: Workout
    let index: Int
    let viewModel: WorkoutViewModel

    @State private var showingEditWorkout = false

    var body: some View {
        List {
            workoutDateSection
            exerciseSections
        }
        .navigationTitle("Workout Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                    showingEditWorkout = true
                }
            }
        }
        .sheet(isPresented: $showingEditWorkout) {
            EditWorkoutView(
                workout: workout,
                onSave: { updatedWorkout in
                    viewModel.updateWorkout(at: index, with: updatedWorkout)
                }
            )
        }
    }

    private var workoutDateSection: some View {
        Section(header: Text("Workout Date")) {
            Text(formattedDate(workout.date))
        }
    }

    private var exerciseSections: some View {
        ForEach(workout.exercises) { exercise in
            Section(header: Text(exercise.name)) {
                ForEach(exercise.sets.indices, id: \.self) { index in
                    let set = exercise.sets[index]
                    VStack(alignment: .leading) {
                        Text("Set \(index + 1)")
                            .font(.headline)
                        Text("Weight: \(set.weight, specifier: "%.1f") kg, Reps: \(set.reps)")
                            .font(.subheadline)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
