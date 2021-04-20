//
//  ContentView.swift
//  ARPersonalSportCoach
//
//  Created by Loup Masneri on 4/16/21.
//

import SwiftUI

let screen = UIScreen.main.bounds

struct ContentView: View {
    @State var isActive: Bool = false
    @State var selectedWorkout: Workout? = nil
    @State var showProfileView: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                // This prevent: When you click on a cell it open the wrong workout. https://stackoverflow.com/questions/65398123/swiftui-list-foreach-in-combination-with-navigationlink-and-isactive-doesnt
                VStack {
                    if selectedWorkout != nil {
                        NavigationLink(destination: WorkoutDetailView(rootIsActive: $isActive, workout: selectedWorkout!), isActive: $isActive) { EmptyView() }
                    }
                }
                .hidden()
                
                LazyVStack(spacing: 32) {
                    ForEach(workoutData, id: \.id) { workout in
                        Button(action: {
                            self.selectedWorkout = workout
                            self.isActive = true
                        }) {
                            WorkoutCell(workout: workout, headerColor: Color(workout.exercises[0].color))
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
                    showProfileView.toggle()
                }) {
                    Image(systemName: "person.crop.circle")
                        .foregroundColor(.customBlack)
                        .font(.largeTitle)
                }
                .sheet(isPresented: $showProfileView) { ProfileView() }
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
