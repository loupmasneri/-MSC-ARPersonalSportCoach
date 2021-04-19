//
//  WorkoutExerciseView.swift
//  ARPersonalSportCoach
//
//  Created by Loup Masneri on 4/19/21.
//

import SwiftUI
import RealityKit

struct WorkoutExerciseView: View {
    @State var globalHours: Int = 0
    @State var globalMinutes: Int = 0
    @State var globalSeconds: Int = 0
    @State var hours: Int = 0
    @State var minutes: Int = 0
    @State var seconds: Int = 0
    @State var globalTimer: Timer? = nil
    @State var currentExerciseTimer: Timer? = nil
    @State var currentExercise: Exercise
    @State var currentRound: Int = 1
    var workout: Workout
    
    init(workout: Workout) {
        self.workout = workout
        _currentExercise = State(initialValue: workout.exercises[0])
    }
    
    private func showTimer(minutes: Int, seconds: Int) -> String {
        var text = ""
        
        text += minutes > 9 ? "\(minutes)" : "0\(minutes)"
        text += ":"
        text += seconds > 9 ? "\(seconds)" : "0\(seconds)"
        
        return text
    }
    
    private func startGlobalTimer() {
        // 1. Make a new timer
        globalTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { tempTimer in
            // 2. Check time to add to H:M:S
            if self.globalSeconds == 59 {
                self.globalSeconds = 0
            if self.globalMinutes == 59 {
                self.globalMinutes = 0
                self.globalHours = self.globalHours + 1
            } else {
                self.globalMinutes = self.globalMinutes + 1
            }
            } else {
                self.globalSeconds = self.globalSeconds + 1
            }
        }
    }
    
    private func startExerciseTimer() {
        // 1. Make a new timer
        currentExerciseTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { tempTimer in
            // 2. Check time to add to H:M:S
            if self.seconds == 59 {
                self.seconds = 0
            if self.minutes == 59 {
                self.seconds = 0
                self.hours = self.hours + 1
            } else {
                self.seconds = self.seconds + 1
            }
            } else {
                self.seconds = self.seconds + 1
            }
        }
    }

    var body: some View {
        ZStack {
            // TODO SHOW AR VIEW HERE INSTEAD OF TEXT HELLO WORLD
            Text("Hello, World!")
                .onAppear(perform: {
                    startGlobalTimer()
                    startExerciseTimer()
            })
            
            VStack {
                Spacer()
                
                VStack {
                    HStack {
                        Image((currentExercise.icons.first)!)
                            .resizable()
                            .frame(width: 64, height: 64)
                            .aspectRatio(contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .padding()
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("\(currentExercise.name) - \(currentExercise.repetitions)")
                                .bold()
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                            
                            Text(showTimer(minutes: self.minutes, seconds: self.seconds))
                                .bold()
                                .font(.system(size: 18))
                                .foregroundColor(.white)
                        }
                    }
                    .frame(width: screen.width)
                    
                    if currentExercise.id == workout.exercises[workout.exercises.count].id && currentRound == workout.rounds {
                        NavigationLink(destination: WorkoutSummaryView(hours: hours, minutes: minutes, seconds: seconds, workout: workout)) {
                            Text("Begin workout")
                                .bold()
                                .font(.system(size: 18))
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: screen.width - (16 * 2))
                                .background(Color.red)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        .buttonStyle(ScaleButtonStyle())
                    } else {
                        Button(action: {
                            print("next exercise")
                        }) {
                            Text("Next exercise")
                                .bold()
                                .font(.system(size: 18))
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: screen.width - (16 * 2))
                                .background(Color.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        .buttonStyle(ScaleButtonStyle())
                    }
                }
            }
            
        }
        .background(Color.black)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadBox()
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct WorkoutExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutExerciseView(workout: workoutData[0])
    }
}
#endif
