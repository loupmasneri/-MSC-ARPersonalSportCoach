//
//  WorkoutDetailView.swift
//  ARPersonalSportCoach
//
//  Created by Loup Masneri on 4/16/21.
//

import SwiftUI

struct WorkoutDetailView: View {
    @State var selectedModel: Model?
    @State var isButtonActivated: Bool = false
    @Binding var rootIsActive: Bool
    var workout: Workout
    let layout = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State var models: [Model] = []
    
    private func loadModels() -> [Model] {
        let fileManager = FileManager.default
        
        guard let path = Bundle.main.resourcePath,
              let files = try? fileManager.contentsOfDirectory(atPath: path)
        else {
            return []
        }
        
        var availableModels: [Model] = []
        for filename in files where filename.hasSuffix(".usdz") {
            let modelName = filename.replacingOccurrences(of: ".usdz", with: "")
            // Only append the model in the array if he is one of the exercise
            if workout.exercises.contains(where: {$0.modelName == modelName}) {
                let model = Model(modelName: modelName)
                availableModels.append(model)
            }
        }
        
        let firstModelIndex = availableModels.firstIndex(where: {$0.modelName == workout.exercises.first?.modelName})
        selectedModel = availableModels[firstModelIndex ?? 0]
        return availableModels
        
    }
    
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
                        NavigationLink(destination: ExerciseDetailView(selectedModel: models.count > 0 ? models[models.firstIndex(where: {$0.modelName == exercise.modelName})!] : nil, model: models.count > 0 ? models[models.firstIndex(where: {$0.modelName == exercise.modelName})!] : nil)) {
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
                    NavigationLink(destination: WorkoutExerciseView(rootIsActive: $rootIsActive, selectedModel: $selectedModel, workout: workout, models: models)) {
                        Text("Begin workout")
                            .bold()
                            .font(.system(size: 18))
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: screen.width - (16 * 2))
//                            .background(Color.blue)
                            .background(isButtonActivated ? Color.blue : Color.gray)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding(.bottom, 32)
                    }
                    .buttonStyle(BackgroundGradientStyle(gradientColors: [Color.customWhite.opacity(0.001), .customWhite]))
                    .disabled(!isButtonActivated)
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .onAppear(perform: {
            self.models = loadModels()
            self.isButtonActivated = true
        })
    }
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDetailView(rootIsActive: .constant(false), workout: workoutData[1])
    }
}
