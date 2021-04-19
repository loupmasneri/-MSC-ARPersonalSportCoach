//
//  ContentView.swift
//  ARPersonalSportCoach
//
//  Created by Loup Masneri on 4/16/21.
//

import SwiftUI

let screen = UIScreen.main.bounds

struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 32) {
                    ForEach(workoutData, id: \.id) { workout in
                        NavigationLink(destination: WorkoutDetailView(workout: workout)) {
                            WorkoutCell(workout: workout)
                        }
                        .buttonStyle(ScaleButtonStyle())
                    }
                }
                .padding(.top)
            }
            .navigationBarTitle(Text("Workouts"), displayMode: .large)
            .navigationBarHidden(false)
            .navigationBarItems(
                trailing: Button(action: {
                    print("DEBUG: Profile")
                }) {
                    Image(systemName: "person.crop.circle")
                        .foregroundColor(.customBlack)
                        .font(.largeTitle)
                }
            )
        }
        
    }
}

struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
