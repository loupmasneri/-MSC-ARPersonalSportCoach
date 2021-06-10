//
//  ExerciseDetailView.swift
//  ARPersonalSportCoach
//
//  Created by Loup Masneri on 6/10/21.
//

import SwiftUI
import RealityKit
import ARKit
import ReplayKit
import UIKit

struct ExerciseDetailView: View {
    @State var selectedModel: Model?
    var model: Model?

    var body: some View {
        ZStack {
            ARViewContainer(model: $selectedModel)
                .edgesIgnoringSafeArea(.all)
        }
        .navigationBarItems(
            trailing: Button(action: {
                selectedModel = model
            }) {
                Text("Move the Coach")
                    .foregroundColor(.red)
            }
            .buttonStyle(ScaleButtonStyle())
        )
    }
}

private struct ARViewContainer: UIViewRepresentable {
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
        let anchorEntity: AnchorEntity = AnchorEntity(plane: .any)

        // This allow to move the current model when pression "Move the coach"
        for entity in anchorEntity.children {
            entity.removeFromParent()
        }

        if let modelEntity = model.entity {
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
