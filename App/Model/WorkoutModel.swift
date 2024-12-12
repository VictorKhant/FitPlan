//
//  WorkoutModel.swift
//  FitPlan
//
//  Created by Myat Minn Khant on 12/2/24.
//
import SwiftUI
import SwiftData

@Model
class Workout: Identifiable{
    var name: String
    var type: WorkoutType
    var isCompleted: Bool = false
    var typeWorkout: TypeWorkout?
    init(name: String, type: WorkoutType, typeWorkout: TypeWorkout){
        self.name = name
        self.type = type
        self.isCompleted = false
        self.typeWorkout = typeWorkout
    }
}

@Model
class TypeWorkout: Identifiable{
    var name: String
    var numOfWorkouts: Int
    @Relationship(deleteRule: .cascade, inverse: \Workout.typeWorkout)var workouts: [Workout]
    init(){
        self.name = ""
        self.numOfWorkouts = 0
        self.workouts = []
    }
    init(name: String){
        self.name = name
        self.numOfWorkouts = 0
        self.workouts = []
    }
}

enum WorkoutType: String, CaseIterable, Identifiable, Codable {
    case strength = "Strength"
    case cardio = "Cardio"
    case flexibility = "Flexibility"
    var id: Self { self }
    var color: Color {
            switch self {
            case .strength:
                return .red
            case .cardio:
                return .blue
            case .flexibility:
                return .green
            }
        }
}
