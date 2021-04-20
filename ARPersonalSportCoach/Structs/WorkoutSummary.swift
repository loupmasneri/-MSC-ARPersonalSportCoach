//
//  WorkoutSummary.swift
//  ARPersonalSportCoach
//
//  Created by Loup Masneri on 4/20/21.
//

import Foundation

struct WorkoutSummary: Codable {
    var id = UUID()
    let workout: Workout
    let date: Date
    let hours: Int
    let minutes: Int
    let seconds: Int
}
