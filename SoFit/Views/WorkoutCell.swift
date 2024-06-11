//
//  WorkoutCell.swift
//  SoFit
//
//  Created by Narayana Wijaya on 04/06/24.
//

import SwiftUI

struct WorkoutCell: View {
    var workout = Workout(name: "", imageName: "", duration: 0, distance: 0, calories: 0, date: Date.now)
    
    var body: some View {
        HStack {
            Image(workout.imageName)
                .resizable()
                .padding(.all, 10)
                .frame(width: 100, height: 100)
            VStack(alignment: .leading) {
                Text(verbatim: workout.name).bold()
                HStack {
                    Image(systemName: "stopwatch")
                        .foregroundStyle(Color.blue)
                    Text(verbatim: workout.duration.asDurationFormat(style: .short))
                }
                HStack {
                    Image(systemName: "flame.fill")
                        .foregroundStyle(Color.red)
                    Text(verbatim: "\(workout.calories) kCal")
                }
                HStack {
                    Image(systemName: "point.topleft.down.to.point.bottomright.curvepath")
                    Text(verbatim: "\(workout.distance) km")
                }
            }
            .padding(.leading, 10)
            Spacer()
        }
    }
}

struct WorkoutCell_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutCell(workout: Workout(name: "Walking",
                                     imageName: "Walking",
                                     duration: 60,
                                     distance: 5,
                                     calories: 350, date: Date.now))
    }
}
