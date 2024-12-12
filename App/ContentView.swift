//
//  HomeView.swift
//  FitPlan
//
//  Created by Myat Minn Khant on 12/2/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var context
    var body: some View {
        NavigationStack{
            VStack(spacing: 20) {
                Spacer()
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                
                Text("FitPlan")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Plan Your Best Workout!")
                    .font(.headline)
                    .foregroundColor(.gray)
                
                Spacer()
                
                NavigationLink(destination: WorkoutScheduleView()) {
                    Text("Get Started")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
