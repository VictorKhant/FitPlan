//
//  UserManager.swift
//  FitPlan
//
//  Created by Myat Minn Khant on 12/2/24.
//

import SwiftUI
@Observable
class WorkoutTypeManager {
    var workoutTypes: [TypeWorkout]
    init() {
        workoutTypes = generateWorkoutTypes()
    }
}
private var workoutTypeNames = [
    "Chest",
    "Back",
    "Shoulder",
    "Legs",
    "Triceps",
    "Biceps",
    "Core",
    "Cardio",
]
func generateWorkoutTypes() -> [TypeWorkout] {
    var generatedWorkoutTypes = [TypeWorkout]()
    for name in workoutTypeNames {
        generatedWorkoutTypes.append(TypeWorkout(name: name))
    }
    return generatedWorkoutTypes
}
