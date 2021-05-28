//
//  Model.swift
//  ARPersonalSportCoach
//
//  Created by Loup Masneri on 5/28/21.
//

import UIKit
import RealityKit
import Combine

class Model: Identifiable {
    var id = UUID()
    var modelName: String
    var entity: Entity? // Use Entity instead of ModelEntity if you want the animation to work https://stackoverflow.com/questions/65591637/play-usdz-animation-in-realitykit
    
    private var cancellable: AnyCancellable? = nil
    
    init(modelName: String) {
        self.modelName = modelName
        
        let filename = modelName + ".usdz"
        self.cancellable = Entity.loadAsync(named: filename)
            .sink(receiveCompletion: { loadCompletion in
                if case let .failure(error) = loadCompletion {
                    // Handle our error
                    print("DEBUG: Unable to load a model due to error \(error)")
                }
//                self.cancellable?.cancel()
            }, receiveValue: { entity in
                // Get our model entity
                entity.setScale([0.80, 0.80, 0.80], relativeTo: entity)
                self.entity = entity
//                self.cancellable?.cancel()
                print("DEBUG: Successfully load model Entity for modelName: \(self.modelName)")
            })
    }
}
