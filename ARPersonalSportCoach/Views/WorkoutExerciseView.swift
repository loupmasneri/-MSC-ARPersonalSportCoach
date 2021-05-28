//
//  WorkoutExerciseView.swift
//  ARPersonalSportCoach
//
//  Created by Loup Masneri on 4/19/21.
//

import SwiftUI
import RealityKit
import ARKit
import ReplayKit
import UIKit

struct WorkoutExerciseView: View {
    @State var globalHours: Int = 0
    @State var globalMinutes: Int = 0
    @State var globalSeconds: Int = 0
    @State var hours: Int = 0
    @State var minutes: Int = 0
    @State var seconds: Int = 0
    @State var globalTimer: Timer? = nil
    @State var currentExerciseTimer: Timer? = nil
    @State var currentExercise: Int = 0
    @State var currentRound: Int = 1
    @Binding var rootIsActive: Bool
    @Binding var selectedModel: Model?
    var workout: Workout
    var models: [Model]
    
    private func showTimer(minutes: Int, seconds: Int) -> String {
        var text = ""
        
        text += minutes > 9 ? "\(minutes)" : "0\(minutes)"
        text += ":"
        text += seconds > 9 ? "\(seconds)" : "0\(seconds)"
        
        return text
    }
    
    private func startGlobalTimer() {
        // 1. Make a new timer
        guard globalTimer == nil else {
            globalTimer?.invalidate()
            globalTimer = nil
            return
        }
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
    
    func startExerciseTimer() {
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
            ARViewContainer(model: $selectedModel)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()

                VStack {
                    Text("Round \(currentRound)/\(workout.rounds)")
                        .bold()
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                    HStack {
                        Image((workout.exercises[currentExercise].icons.first)!)
                            .resizable()
                            .frame(width: 64, height: 64)
                            .aspectRatio(contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .padding()

                        VStack(alignment: .leading, spacing: 8) {
                            Text("\(workout.exercises[currentExercise].name) - \(workout.exercises[currentExercise].repetitions)")
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

                    NextExerciseButtonView(selectedModel: $selectedModel, models: models, currentExercise: $currentExercise, currentRound: $currentRound, globalTimer: $globalTimer, currentExerciseTimer: $currentExerciseTimer, globalHours: $globalHours, globalMinutes: $globalMinutes, globalSeconds: $globalSeconds, hours: $hours, minutes: $minutes, seconds: $seconds, rootIsActive: $rootIsActive, startExerciseTimer: startExerciseTimer, workout: workout)
                }
            }
            
        }
        .navigationBarItems(
            trailing: Button(action: {
                let nextModelIndex = models.firstIndex(where: {$0.modelName == workout.exercises[currentExercise].modelName})
                selectedModel = models[nextModelIndex!]
            }) {
                Text("Move the Coach")
                    .foregroundColor(.red)
            }
            .buttonStyle(ScaleButtonStyle())
        )
        .onAppear(perform: {
            selectedModel = models[0]
            startGlobalTimer()
            startExerciseTimer()
        })
        .background(Color.black)
        
    }
}

struct NextExerciseButtonView: View {
    @Binding var selectedModel: Model?
    var models: [Model]
    @Binding var currentExercise: Int
    @Binding var currentRound: Int
    @Binding var globalTimer: Timer?
    @Binding var currentExerciseTimer: Timer?
    @Binding var globalHours: Int
    @Binding var globalMinutes: Int
    @Binding var globalSeconds: Int
    @Binding var hours: Int
    @Binding var minutes: Int
    @Binding var seconds: Int
    @Binding var rootIsActive: Bool
    var startExerciseTimer: () -> Void
    var workout: Workout
    
    private func resetTimer() {
        currentExerciseTimer!.invalidate()
        currentExerciseTimer = nil
        hours = 0
        minutes = 0
        seconds = 0
        startExerciseTimer()
    }
    
    var body: some View {
        if workout.exercises[currentExercise].id == workout.exercises[workout.exercises.count - 1].id && currentRound == workout.rounds {
            NavigationLink(destination: WorkoutSummaryView(globalTimer: $globalTimer, shouldPopToRootView: $rootIsActive, hours: globalHours, minutes: globalMinutes, seconds: globalSeconds, workout: workout)) {
                Text("Finish workout")
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
                if currentExercise == workout.exercises.count - 1 {
                    currentExercise = 0
                    currentRound += 1
                } else {
                    currentExercise += 1
                    let nextModelIndex = models.firstIndex(where: {$0.modelName == workout.exercises[currentExercise].modelName})
                    selectedModel = models[nextModelIndex!]
                }
                resetTimer()
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

struct ARViewContainer: UIViewRepresentable {
    @Binding var model: Model?
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        let config = ARWorldTrackingConfiguration()
        
        config.planeDetection = [.horizontal]
        config.environmentTexturing = .automatic
        
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
            config.sceneReconstruction = .mesh
        }
        
        arView.session.run(config)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        guard let model = model else { return }

        if let modelEntity = model.entity {
            let anchorEntity = AnchorEntity(plane: .any)
            anchorEntity.addChild(modelEntity)

            uiView.scene.addAnchor(anchorEntity)
            for anim in modelEntity.availableAnimations {
                modelEntity.playAnimation(anim.repeat(duration: .infinity), transitionDuration: 1.25, startsPaused: false)
            }
        } else {
            print("DEBUG: Unable to load modelEntity named: \(model.modelName)")
        }

        DispatchQueue.main.async {
            self.model = nil
        }
        
    }
    
}
