import Foundation

class WorkoutViewModel: ObservableObject {
    @Published var workouts: [Workout] = []

    // Add a workout to the list
    func addWorkout(_ workout: Workout) {
        workouts.append(workout)
    }

    // Delete a workout from the list
    func deleteWorkout(at offsets: IndexSet) {
        workouts.remove(atOffsets: offsets)
    }

    // Update a workout at a specific index
    func updateWorkout(at index: Int, with updatedWorkout: Workout) {
        guard workouts.indices.contains(index) else { return }
        workouts[index] = updatedWorkout
    }
}
