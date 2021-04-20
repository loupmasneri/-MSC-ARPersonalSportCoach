//
//  UserDefaultsHelper.swift
//  ARPersonalSportCoach
//
//  Created by Loup Masneri on 4/20/21.
//

import Foundation

class UserDefaultsHelper {
    
    public func getWorkoutSummaries() -> [WorkoutSummary] {
        if let data = UserDefaults.standard.data(forKey: "workoutSummary") {
            if let decoded = try? JSONDecoder().decode([WorkoutSummary].self, from: data) {
                return decoded
            }
        }
        return []
    }
    
    public func saveWorkoutSummary(_ workoutSummary: WorkoutSummary) {
        var workoutSummaries = getWorkoutSummaries()
        workoutSummaries.append(workoutSummary)
        
        if let encoded = try? JSONEncoder().encode(workoutSummaries) {
            UserDefaults.standard.set(encoded, forKey: "workoutSummary")
        }
    }
}
