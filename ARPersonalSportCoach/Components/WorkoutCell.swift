//
//  WorkoutCell.swift
//  ARPersonalSportCoach
//
//  Created by Loup Masneri on 4/16/21.
//

import SwiftUI

struct WorkoutCell: View {
    var workout: Workout
    var headerColor: Color
    var height = screen.width - 32
    
    var body: some View {
        HStack {
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
                        .padding(.top, 4)
                
                    Spacer()
                }
                .padding()
                
                Spacer()
            }
            .frame(height: height > 150 ? 150 : 80)
            .background(LinearGradient(gradient: Gradient(colors: [headerColor, headerColor.opacity(0.001)]), startPoint: .top, endPoint: .bottom))
        }
        .frame(width: screen.width - 32, height: height, alignment: .top)
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
        WorkoutCell(workout: workoutData[1], headerColor: .blue)
    }
}
