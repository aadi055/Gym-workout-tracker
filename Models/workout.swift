// Workout.swift
import Foundation

struct Workout: Identifiable, Codable {
    let id: UUID
    var date: Date
    var exercises: [Exercise]

    init(id: UUID = UUID(), date: Date, exercises: [Exercise]) {
        self.id = id
        self.date = date
        self.exercises = exercises
    }
}

struct Exercise: Identifiable, Codable {
    let id: UUID
    var name: String
    var sets: [ExerciseSet]

    init(id: UUID = UUID(), name: String, sets: [ExerciseSet]) {
        self.id = id
        self.name = name
        self.sets = sets
    }
}

struct ExerciseSet: Identifiable, Codable {
    let id: UUID
    var weight: Double
    var reps: Int

    init(id: UUID = UUID(), weight: Double, reps: Int) {
        self.id = id
        self.weight = weight
        self.reps = reps
    }
}
