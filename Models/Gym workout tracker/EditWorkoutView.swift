// EditWorkoutView.swift
import SwiftUI

struct EditWorkoutView: View {
    @Environment(\.dismiss) var dismiss

    @State var workout: Workout
    var onSave: (Workout) -> Void

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Workout Date")) {
                    DatePicker("Date", selection: $workout.date, displayedComponents: .date)
                }

                ForEach(workout.exercises.indices, id: \.self) { exerciseIndex in
                    Section(header: Text("Exercise \(exerciseIndex + 1)")) {
                        TextField("Exercise Name", text: $workout.exercises[exerciseIndex].name)

                        ForEach(workout.exercises[exerciseIndex].sets.indices, id: \.self) { setIndex in
                            VStack(alignment: .leading) {
                                Text("Set \(setIndex + 1)").font(.headline)

                                HStack {
                                    Text("Weight:")
                                    TextField("kg", value: $workout.exercises[exerciseIndex].sets[setIndex].weight, format: .number)
                                        .keyboardType(.decimalPad)
                                }

                                HStack {
                                    Text("Reps:")
                                    TextField("reps", value: $workout.exercises[exerciseIndex].sets[setIndex].reps, format: .number)
                                        .keyboardType(.numberPad)
                                }

                                Button(role: .destructive) {
                                    workout.exercises[exerciseIndex].sets.remove(at: setIndex)
                                } label: {
                                    Label("Delete Set", systemImage: "trash")
                                }
                                .padding(.top, 4)
                            }
                        }

                        Button {
                            workout.exercises[exerciseIndex].sets.append(ExerciseSet(weight: 0, reps: 0))
                        } label: {
                            Label("Add Set", systemImage: "plus")
                        }
                    }
                }

                Button {
                    workout.exercises.append(Exercise(name: "", sets: [ExerciseSet(weight: 0, reps: 0)]))
                } label: {
                    Label("Add Exercise", systemImage: "plus")
                }
            }
            .navigationTitle("Edit Workout")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(workout)
                        dismiss()
                    }
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}
