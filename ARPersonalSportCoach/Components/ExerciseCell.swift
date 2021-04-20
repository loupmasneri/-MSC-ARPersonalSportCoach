//
//  ExerciseCell.swift
//  ARPersonalSportCoach
//
//  Created by Loup Masneri on 4/16/21.
//

import SwiftUI

struct ExerciseCell: View {
    var exercise: Exercise
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    ForEach(exercise.icons, id: \.self) { icon in
                        Image(icon)
                            .resizable()
                            .frame(width: 40, height: 40)
                            .aspectRatio(contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
                
                Spacer()
                
                Text(exercise.name)
                    .foregroundColor(.white)
                    .bold()
                    .font(.system(size: 18))
                Text(exercise.repetitions)
                    .foregroundColor(.white)
                    .font(.system(size: 16))
            }
            .padding(.all, 8)
            
            Spacer()
        }
        // 16 * 2 is the padding leading,trailing and the -8 is to remove the space between cells
        .frame(width: screen.width / 2 - (16 * 2 - 8), height: 124)
        .background(Color(exercise.color))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: Color(exercise.color).opacity(0.40), radius: 6, x: 0, y: 6)
    }
}

struct ExerciseCell_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseCell(exercise: workoutData[0].exercises[0])
    }
}
