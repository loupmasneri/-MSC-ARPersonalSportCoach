//
//  ProfileView.swift
//  ARPersonalSportCoach
//
//  Created by Loup Masneri on 4/20/21.
//

import SwiftUI

struct ProfileView: View {
    @State var workoutSummaries: [WorkoutSummary] = UserDefaultsHelper().getWorkoutSummaries()
    
    private func transformDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMMd-h:mm a")
        let string = dateFormatter.string(from: date)
        return string
    }
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 32) {
                    ForEach(workoutSummaries, id: \.id) { workoutSummary in
                        NavigationLink(destination: WorkoutSummaryView(globalTimer: Binding.constant(nil), shouldPopToRootView: .constant(false), comeFromProfile: true, hours: workoutSummary.hours, minutes: workoutSummary.minutes, seconds: workoutSummary.seconds, workout: workoutSummary.workout)) {
                            WorkoutCell(workout: Workout(name: transformDate(workoutSummary.date), description: "You have done the \(workoutSummary.workout.name) workout", image: workoutSummary.workout.image, rounds: workoutSummary.workout.rounds, exercises: workoutSummary.workout.exercises), headerColor: Color(workoutSummary.workout.exercises[0].color), height: 120)
                        }
                        .buttonStyle(ScaleButtonStyle())
                    }
                }
                .padding(.top)
            }
            .navigationBarTitle(Text("Profile"), displayMode: .large)
            .navigationBarHidden(false)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
