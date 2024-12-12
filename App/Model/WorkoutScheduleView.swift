//
//  WorkoutScheduleView.swift
//  FitPlan
//
//  Created by Myat Minn Khant on 12/2/24.
//
import SwiftUI
import _SwiftData_SwiftUI
struct WorkoutScheduleView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    @Query private var workoutTypes: [TypeWorkout]
    @State private var showAddWorkout = false
    @State private var selectedType = TypeWorkout()
    @State private var showChangeUserView = false
    var body: some View {
            VStack {
                List{
                    ForEach($selectedType.workouts) { $workout in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(workout.name)
                                    .font(.headline)
                                Text(workout.type.rawValue)
                                    .font(.subheadline)
                                    .foregroundStyle(workout.type.color)
                            }
                            Spacer()
                            Button(action: {
                                withAnimation {
                                    workout.isCompleted.toggle()
                                }
                            }) {
                                Image(systemName: workout.isCompleted ? "checkmark.circle.fill" : "circle")
                                .font(.system(size: 20))
                            }
                        }
                    }
                    .onDelete(perform: deleteWorkout)
                }
                
                
                Button("Add Workout") {
                    showAddWorkout.toggle()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding()
            }
            .onAppear {
                if selectedType.name.isEmpty {
                    showChangeUserView.toggle()
                }
            }
            .onChange(of: selectedType) {
                if (selectedType.name == "Empty") {
                    dismiss()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("\(selectedType.name)"){
                        showChangeUserView.toggle()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    if !selectedType.workouts.isEmpty {
                                    EditButton()
                    }
                }
                
            }
            .fullScreenCover(isPresented: $showChangeUserView){
                ChangeWorkoutView(selectedType: $selectedType)
            }
            .navigationTitle("Workout Schedule")
            .sheet(isPresented: $showAddWorkout) {
                AddWorkoutView(selectedType: $selectedType)
            }
        
    }
    private func deleteWorkout(at offsets: IndexSet) {
        for offset in offsets {
            let workoutToDelete = selectedType.workouts[offset]
            context.delete(workoutToDelete)
            selectedType.numOfWorkouts -= 1
        }
        do {
            try context.save()
        }
        catch {
            
        }
    }
}

struct AddWorkoutView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    @Binding var selectedType: TypeWorkout
    @State private var workoutName = ""
    @State private var workoutType:WorkoutType = .strength
    @State private var showAlert = false
    var body: some View {
        NavigationView {
            Form {
                TextField("Workout Name", text: $workoutName)
                List {
                    Picker("Workout Type", selection: $workoutType){
                        Text("Strength").tag(WorkoutType.strength)
                        Text("Cardio").tag(WorkoutType.cardio)
                        Text("Flexibility").tag(WorkoutType.flexibility)
                    }
                }
            }
            .navigationTitle("Add Workout")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if (!workoutName.isEmpty) {
                            let newWorkout = Workout(name: workoutName, type: workoutType, typeWorkout: selectedType)
                            context.insert(newWorkout)
                            do {
                                try context.save()
                            }
                            catch {
                                print("Failed to save new Workout")
                            }
                            selectedType.workouts.append(newWorkout)
                            selectedType.numOfWorkouts += 1
                            dismiss()
                        }
                        else{
                            showAlert = true
                        }
                    }
                }
            }
            .alert("Invalid Input", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Workout name cannot be empty. Please enter a valid name.")
            }
        }
    }
}

#Preview{
    @Previewable @State var temp = WorkoutTypeManager()
    WorkoutScheduleView()
}
