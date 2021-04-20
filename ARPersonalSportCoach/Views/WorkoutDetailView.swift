//
//  WorkoutDetailView.swift
//  ARPersonalSportCoach
//
//  Created by Loup Masneri on 4/16/21.
//

import SwiftUI

struct WorkoutDetailView: View {
    @Binding var rootIsActive: Bool
    var workout: Workout
    let layout = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            ScrollView {
                Text("\(workout.rounds) rounds")
                    .bold()
                    .font(.title2)
                    .foregroundColor(.customBlack)
                    .padding(.top)
                LazyVGrid(columns: layout, spacing: 16) {
                    ForEach(workout.exercises, id: \.id) { exercise in
                        NavigationLink(destination: Text("Destination")) {
                            ExerciseCell(exercise: exercise)
                        }
                        .buttonStyle(ScaleButtonStyle())
                    }
                }
                .padding(.top)
                .padding(.horizontal, 32)
                .padding(.bottom, 96)
            }
            .navigationTitle(workout.name)
            
            VStack {
                Spacer()
                VStack {
                    NavigationLink(destination: WorkoutExerciseView(rootIsActive: $rootIsActive, workout: workout)) {
                        Text("Begin workout")
                            .bold()
                            .font(.system(size: 18))
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: screen.width - (16 * 2))
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding(.bottom, 32)
                    }
                    .buttonStyle(BackgroundGradientStyle(gradientColors: [Color.customWhite.opacity(0.001), .customWhite]))
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDetailView(rootIsActive: .constant(false), workout: workoutData[1])
    }
}
