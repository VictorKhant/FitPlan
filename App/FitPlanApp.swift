//
//  FitPlanApp.swift
//  FitPlan
//
//  Created by Myat Minn Khant on 12/2/24.
//

import SwiftUI
import SwiftData

@main
struct FitPlanApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for:[Workout.self, TypeWorkout.self])
        }
    }
}
