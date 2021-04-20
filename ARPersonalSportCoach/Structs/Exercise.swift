//
//  Exercise.swift
//  ARPersonalSportCoach
//
//  Created by Loup Masneri on 4/16/21.
//

import SwiftUI

struct Exercise: Codable {
    var id = UUID()
    var icons: [String]
    var color: String
    var name: String
    var repetitions: String
}
