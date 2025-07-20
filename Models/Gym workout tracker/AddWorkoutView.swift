import SwiftUI

struct AddWorkoutView: View {
    @Environment(\.presentationMode) var presentationMode

    @State private var workoutDate: Date = Date()
    @State private var exercises: [ExerciseInput] = [ExerciseInput()]

    var onSave: (Workout) -> Void

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Workout Date")) {
                    DatePicker("Date", selection: $workoutDate, displayedComponents: .date)
                }

                Section(header: Text("Exercises")) {
                    ForEach(exercises.indices, id: \.self) { exerciseIndex in
                        VStack(alignment: .leading, spacing: 8) {
                            TextField("Exercise Name", text: $exercises[exerciseIndex].name)
                                .textFieldStyle(RoundedBorderTextFieldStyle())

                            ForEach(exercises[exerciseIndex].sets.indices, id: \.self) { setIndex in
                                HStack {
                                    Text("Set \(setIndex + 1):")
                                    Spacer()
                                    TextField("Weight", value: $exercises[exerciseIndex].sets[setIndex].weight, formatter: NumberFormatter())
                                        .keyboardType(.decimalPad)
                                        .frame(width: 80)
                                    TextField("Reps", value: $exercises[exerciseIndex].sets[setIndex].reps, formatter: NumberFormatter())
                                        .keyboardType(.numberPad)
                                        .frame(width: 60)
                                }
                            }

                            Button(action: {
                                exercises[exerciseIndex].sets.append(ExerciseSet(weight: 0, reps: 0))
                            }) {
                                Label("Add Set", systemImage: "plus.circle.fill")
                            }
                            .padding(.top, 4)
                        }
                        .padding(.vertical)
                    }

                    Button(action: {
                        exercises.append(ExerciseInput())
                    }) {
                        Label("Add Exercise", systemImage: "plus")
                    }
                }

                Button("Save Workout") {
                    let finalExercises = exercises.map {
                        Exercise(name: $0.name, sets: $0.sets)
                    }
                    let workout = Workout(date: workoutDate, exercises: finalExercises)
                    onSave(workout)
                    presentationMode.wrappedValue.dismiss()
                }
                .font(.headline)
                .foregroundColor(.blue)
            }
            .navigationTitle("Add Workout")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// Temporary input model used only in AddWorkoutView
struct ExerciseInput {
    var name: String = ""
    var sets: [ExerciseSet] = [ExerciseSet(weight: 0, reps: 0)]
}
