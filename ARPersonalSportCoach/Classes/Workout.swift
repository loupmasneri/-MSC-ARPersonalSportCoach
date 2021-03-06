//
//  Workout.swift
//  ARPersonalSportCoach
//
//  Created by Loup Masneri on 4/16/21.
//

import Foundation

class Workout: Identifiable, Codable {
    var id = UUID()
    var name: String
    var description: String
    var image: String
    var rounds: Int
    var exercises: [Exercise]
    
    init(name: String, description: String, image: String, rounds: Int, exercises: [Exercise]) {
        self.name = name
        self.description = description
        self.image = image
        self.rounds = rounds
        self.exercises = exercises
    }
}

// Used to preview some content (from the prototype on Figma) https://www.figma.com/file/IbdR1Tb8l5rWcUYqnA9xiA/MSC-App?node-id=0%3A1
var workoutData: [Workout] = [
    Workout(name: "Upper body", description: "Work your arms, shoulders, perctorals and abdominals", image: "upperBody", rounds: 7, exercises: [
        Exercise(icons: ["pecArms"], color: "pushUp", name: "Push up", repetitions: "5 reps", modelName: "pushup"),
        Exercise(icons: ["pecMiddle"], color: "largePushUp", name: "Large push up", repetitions: "5 reps", modelName: "largepushup"),
        Exercise(icons: ["upperPecShoulders"], color: "declinePushUp", name: "Decline push up", repetitions: "5 reps", modelName: "pushup"),
        Exercise(icons: ["pecArms"], color: "pushUp", name: "Push up", repetitions: "5 reps", modelName: "pushup"),
        Exercise(icons: ["pecMiddleArms"], color: "diamondPushUp", name: "Diamond push up", repetitions: "5 reps", modelName: "diamondpushup"),
        Exercise(icons: ["abdominals"], color: "plank", name: "Plank", repetitions: "45 secs", modelName: "plank"),
        Exercise(icons: ["pecArms"], color: "pushUp", name: "Push up", repetitions: "5 reps", modelName: "pushup"),
        Exercise(icons: ["pecMiddleArms"], color: "diamondPushUp", name: "Diamond push up", repetitions: "5 reps", modelName: "diamondpushup"),
        Exercise(icons: ["rest"], color: "customBlack", name: "REST", repetitions: "2 minutes", modelName: "rest"),
    ]),
    Workout(name: "Lower body", description: "Work your legs", image: "lowerBody", rounds: 7, exercises: [
        Exercise(icons: ["upperLegs", "butt"], color: "squat", name: "Squat", repetitions: "15 reps", modelName: "toy_drummer"),
        Exercise(icons: ["rest"], color: "customBlack", name: "REST", repetitions: "15 secs", modelName: "rest"),
        Exercise(icons: ["upperLegs"], color: "lateralSquat", name: "Lateral squat", repetitions: "10 reps / leg", modelName: "lateralsquat"),
        Exercise(icons: ["rest"], color: "customBlack", name: "REST", repetitions: "15 secs", modelName: "rest"),
        Exercise(icons: ["allLegs", "butt"], color: "jumpSquat", name: "Jump squat", repetitions: "10 reps", modelName: "jumpsquat"),
        Exercise(icons: ["rest"], color: "customBlack", name: "REST", repetitions: "15 secs", modelName: "rest"),
        Exercise(icons: ["insideLegs"], color: "janeFonda", name: "Jane fonda", repetitions: "15 reps / leg", modelName: "janefonda"),
        Exercise(icons: ["rest"], color: "customBlack", name: "REST", repetitions: "15 secs", modelName: "rest"),
        Exercise(icons: ["allLegs", "butt"], color: "prisonerWalkUp", name: "Prisoner walk up", repetitions: "20 reps", modelName: "prisonerwalkup"),
        Exercise(icons: ["rest"], color: "customBlack", name: "REST", repetitions: "15 secs", modelName: "rest"),
        Exercise(icons: ["butt"], color: "reverseLunge", name: "Reverse lunge", repetitions: "10 reps", modelName: "reverselunge"),
        Exercise(icons: ["rest"], color: "customBlack", name: "REST", repetitions: "2 mins", modelName: "rest"),
    ])
]
