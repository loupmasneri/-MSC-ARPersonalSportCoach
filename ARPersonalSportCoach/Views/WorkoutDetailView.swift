//
//  WorkoutDetailView.swift
//  ARPersonalSportCoach
//
//  Created by Loup Masneri on 4/16/21.
//

import SwiftUI

struct WorkoutDetailView: View {
    var workout: Workout
    let layout = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: layout, spacing: 16) {
                ForEach(workout.exercises, id: \.id) { exercise in
                    ExerciseCell(exercise: exercise)
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle(workout.name)
    }
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDetailView(workout: workoutData[1])
    }
}
