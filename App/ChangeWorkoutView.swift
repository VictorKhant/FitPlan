//
//  ChangeUser.swift
//  FitPlan
//
//  Created by Myat Minn Khant on 12/2/24.
//

import SwiftUI
import _SwiftData_SwiftUI

struct ChangeWorkoutView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    @Binding var selectedType: TypeWorkout
    @Query private var workoutTypes: [TypeWorkout]
    @State private var showAddWorkoutTypeView = false
    @State private var isEditing = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(workoutTypes) { workoutType in
                    HStack {
                        Text(workoutType.name)
                            .font(.headline)
                        Spacer()
                        Text("\(workoutType.numOfWorkouts) Workouts")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedType = workoutType
                        dismiss()
                    }
                }
                .onDelete(perform: deleteType)
            }
            .navigationTitle("Change Workout Type")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action: {
                        if selectedType.name.isEmpty {
                            selectedType = TypeWorkout(name: "Empty")
                        }
                        dismiss()
                    })
                {
                        Image(systemName: "arrowshape.turn.up.backward")
                            .foregroundColor(.blue)
                            .font(.system(size: 20))
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    EditButton()
                }
                ToolbarItem {
                    Button(action: { showAddWorkoutTypeView.toggle() }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddWorkoutTypeView) {
                AddWorkoutTypeView()
            }
        }
    }

    private func deleteType(at offsets: IndexSet) {
        for offset in offsets {
            let workoutTypeToDelete = workoutTypes[offset]
            if(selectedType == workoutTypes[offset]){
                if(workoutTypes.count > 1){
                    if offset > 0
                    {
                        selectedType = workoutTypes[offset - 1]
                    }
                    else {
                        selectedType = workoutTypes[offset + 1]
                    }
                }
                else {
                    selectedType = TypeWorkout(name: "Empty")
                }
            }
            context.delete(workoutTypeToDelete)
        }
        do {
            try context.save()
        }
        catch {
            
        }
    }
}

struct AddWorkoutTypeView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    @Query private var workoutTypes: [TypeWorkout]
    @State private var userName: String = ""
    @State private var showAlert = false
    var body: some View {
        NavigationStack {
            Form {
                TextField("Enter a Name", text: $userName)
            }
            .navigationTitle("Add New Workout Type")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if !userName.isEmpty {
                            let newUser = TypeWorkout(name: userName)
                            context.insert(newUser)
                            do {
                                try context.save()
                            }
                            catch {
                                
                            }
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
                Text("User name cannot be empty. Please enter a valid name.")
            }
        }
    }
}

struct ChangeUserViewPreview: View {
    @State private var workoutTypes: [TypeWorkout] = [
        TypeWorkout(name: "Chest"),
        TypeWorkout(name: "Back")
    ]
    @State private var selectedType = TypeWorkout()

    var body: some View {
        ChangeWorkoutView(selectedType: $selectedType)
    }
}

#Preview {
    ChangeUserViewPreview()
}
