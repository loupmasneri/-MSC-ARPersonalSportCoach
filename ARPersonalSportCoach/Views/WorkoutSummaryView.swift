//
//  WorkoutSummaryView.swift
//  ARPersonalSportCoach
//
//  Created by Loup Masneri on 4/19/21.
//

import SwiftUI

struct WorkoutSummaryView: View {
    @Binding var globalTimer: Timer?
    @Binding var shouldPopToRootView: Bool
    @Environment(\.presentationMode) var presentation
    var comeFromProfile: Bool = false
    var hours: Int
    var minutes: Int
    var seconds: Int
    var workout: Workout
    let layout = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private func showTimer(hours: Int, minutes: Int, seconds: Int) -> String {
        var text = ""
        
        text += hours > 9 ? "\(hours)" : "0\(hours)"
        text += ":"
        text += minutes > 9 ? "\(minutes)" : "0\(minutes)"
        text += ":"
        text += seconds > 9 ? "\(seconds)" : "0\(seconds)"
        
        return text
    }
    
    private func saveWorkoutInProfile() {
        
        let workoutSummary = WorkoutSummary(workout: workout, date: Date(), hours: hours, minutes: minutes, seconds: seconds)
        UserDefaultsHelper().saveWorkoutSummary(workoutSummary)
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                Text("\(showTimer(hours: hours, minutes: minutes, seconds: seconds))")
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
                .padding(.bottom, 64)
            }
            .navigationTitle(workout.name)
            .navigationBarBackButtonHidden(true)
            .onAppear(perform: {
                if globalTimer != nil {
                    globalTimer!.invalidate()
                    globalTimer = nil
                }
            })
            
            VStack {
                Spacer()
                VStack {
                    Button(action: {
                        if comeFromProfile {
                            self.presentation.wrappedValue.dismiss()
                        } else {
                            saveWorkoutInProfile()
                            self.shouldPopToRootView = false
                        }
                    }) {
                        Text(comeFromProfile ? "Back" : "Home")
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
        WorkoutSummaryView(globalTimer: .constant(nil), shouldPopToRootView: .constant(false), hours: 0, minutes: 34, seconds: 46, workout: workoutData[0])
    }
}
