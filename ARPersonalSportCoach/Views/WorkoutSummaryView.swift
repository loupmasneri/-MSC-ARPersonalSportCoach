//
//  WorkoutSummaryView.swift
//  ARPersonalSportCoach
//
//  Created by Loup Masneri on 4/19/21.
//

import SwiftUI

struct WorkoutSummaryView: View {
    var hours: Int
    var minutes: Int
    var seconds: Int
    var workout: Workout
    let layout = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            ScrollView {
                Text("\(hours):\(minutes):\(seconds)")
                    .bold()
                    .font(.title2)
                    .foregroundColor(.customBlack)
                LazyVGrid(columns: layout, spacing: 16) {
                    ForEach(workout.exercises, id: \.id) { exercise in
                        NavigationLink(destination: Text("Destination")) {
                            ExerciseCell(exercise: exercise)
                        }
                        .buttonStyle(ScaleButtonStyle())
                    }
                }
                .padding(.top)
                .padding(.horizontal)
            }
            .navigationTitle(workout.name)
            
            VStack {
                Spacer()
                VStack {
                    NavigationLink(destination: ContentView()) {
                        Text("Home")
                            .bold()
                            .font(.system(size: 18))
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: screen.width - (16 * 2))
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .buttonStyle(BackgroundGradientStyle(gradientColors: [Color.customWhite.opacity(0.001), .customWhite]))
                }

                
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct WorkoutSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutSummaryView(hours: 0, minutes: 34, seconds: 46, workout: workoutData[0])
    }
}
