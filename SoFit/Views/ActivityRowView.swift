//
//  ActivityGridView.swift
//  SoFit
//
//  Created by Narayana Wijaya on 07/06/24.
//

import SwiftUI

struct ActivityRowView: View {
    var workout = Workout(name: "", imageName: "", duration: 0, distance: 0, calories: 0, date: Date.now)
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(verbatim: workout.name)
                .bold()
                .lineLimit(1)
            HStack {
                Image(workout.imageName)
                    .resizable()
                    .frame(width: 50, height: 50)
                
                HStack(alignment: .firstTextBaseline) {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "stopwatch")
                                .foregroundStyle(Color.blue)
                            Text(workout.duration.asDurationFormat())
                                .font(.caption)
                                .lineLimit(1)
                        }
                        
                        HStack {
                            Image(systemName: "point.topleft.down.to.point.bottomright.curvepath")
                            Text("\(workout.distance) km")
                                .font(.caption)
                                .lineLimit(1)
                        }
                    }
                    .padding(.horizontal, 16)
                    VStack {
                        HStack {
                            Image(systemName: "flame.fill")
                                .foregroundStyle(Color.red)
                            Text("\(workout.calories) kCal")
                                .font(.caption)
                                .lineLimit(1)
                        }
                        HStack {
                            Image(systemName: "list.bullet.clipboard")
                                .foregroundStyle(Color.black)
                            Text("5 Activity")
                                .font(.caption)
                                .lineLimit(1)
                        }
                    }
                }
                Spacer()
            }
            
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    ActivityRowView(workout: Workout(name: "Walking",
                                      imageName: "Walking",
                                      duration: 60,
                                      distance: 5,
                                     calories: 350, date: Date.now))
}
