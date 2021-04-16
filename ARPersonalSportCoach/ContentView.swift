//
//  ContentView.swift
//  ARPersonalSportCoach
//
//  Created by Loup Masneri on 4/16/21.
//

import SwiftUI
import RealityKit

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
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
#endif
