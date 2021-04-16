//
//  WorkoutCell.swift
//  ARPersonalSportCoach
//
//  Created by Loup Masneri on 4/16/21.
//

import SwiftUI

struct WorkoutCell: View {
    var workout: Workout
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(workout.name)
                    .bold()
                    .font(.title)
                    .foregroundColor(.white)
                
                Text(workout.description)
                    .bold()
                    .font(.subheadline)
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding()
            
            Spacer()
        }
        .frame(width: screen.width - 32, height: screen.width - 32, alignment: .top)
        .background(
            Image(workout.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
        )
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: Color.black.opacity(0.25), radius: 10, x: 0, y: 10)
    }
}

struct WorkoutCell_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutCell(workout: workoutData[0])
    }
}
