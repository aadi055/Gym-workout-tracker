import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: WorkoutViewModel
    @StateObject private var bodyWeightViewModel: BodyWeightViewModel

    @State private var showingAddWorkout = false
    @State private var showingProgressView = false

    init(
        viewModel: WorkoutViewModel = WorkoutViewModel(),
        bodyWeightViewModel: BodyWeightViewModel = BodyWeightViewModel()
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _bodyWeightViewModel = StateObject(wrappedValue: bodyWeightViewModel)
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.workouts) { workout in
                    NavigationLink(
                        destination: WorkoutDetailView(
                            workout: workout,
                            index: viewModel.workouts.firstIndex(where: { $0.id == workout.id }) ?? 0,
                            viewModel: viewModel
                        )
                    ) {
                        VStack(alignment: .leading) {
                            Text("Workout on \(formattedDate(workout.date))")
                                .font(.headline)
                            Text("\(workout.exercises.count) exercises")
                                .font(.subheadline)
                        }
                    }
                }
                .onDelete(perform: viewModel.deleteWorkout)
            }
            .navigationTitle("My Workouts")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        showingProgressView = true
                    }) {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddWorkout = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $showingAddWorkout) {
            AddWorkoutView { newWorkout in
                viewModel.addWorkout(newWorkout)
            }
        }
        .sheet(isPresented: $showingProgressView) {
            WorkoutProgressView(
                workoutViewModel: viewModel,
                bodyWeightViewModel: bodyWeightViewModel
            )
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

#Preview {
    let mockWorkout = Workout(
        id: UUID(),
        date: Date(),
        exercises: [
            Exercise(name: "Bench Press", sets: [
                ExerciseSet(weight: 60, reps: 8),
                ExerciseSet(weight: 65, reps: 6)
            ]),
            Exercise(name: "Deadlift", sets: [
                ExerciseSet(weight: 100, reps: 5)
            ])
        ]
    )

    let mockViewModel = WorkoutViewModel()
    mockViewModel.addWorkout(mockWorkout)

    let mockBodyWeightModel = BodyWeightViewModel()
    mockBodyWeightModel.addEntry(date: Date(), weight: 70)
    mockBodyWeightModel.addEntry(date: Date().addingTimeInterval(-86400), weight: 69.5)

    return ContentView(viewModel: mockViewModel, bodyWeightViewModel: mockBodyWeightModel)
}
