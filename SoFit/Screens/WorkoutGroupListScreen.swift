//
//  WorkoutGroupListScreen.swift
//  SoFit
//
//  Created by Narayana Wijaya on 10/06/24.
//

import SwiftUI

struct WorkoutGroupListScreen: View {
    let workouts: GroupedWorkout
    
    var body: some View {
        VStack {
            HStack {
                Image(workouts.imageName)
                    .resizable()
                    .padding(.all, 10)
                    .frame(width: 100, height: 100)
                
                Text(workouts.name)
                    .font(.largeTitle)
            }
            
            HStack {
                Image(systemName: "flame.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(Color.red)
                Text("\(workouts.totalCalories) kCal")
                    .lineLimit(1)
                Divider()
                    .frame(height: 20)
                Image(systemName: "stopwatch")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(Color.blue)
                    
                Text(workouts.totalDuration.asDurationFormat())
                    .lineLimit(1)
            }
            
            List(workouts.workouts) { workout in
                WorkoutCell(workout: workout)
            }
        }
//        .navigationTitle(workouts.name)
//        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    WorkoutGroupListScreen(workouts: GroupedWorkout(name: "Grouped Running Together", imageName: "Running", totalDuration: 100, totalDistance: 20000, totalCalories: 2500, workouts: [Workout(name: "Running", imageName: "Running", duration: 60, distance: 10000, calories: 500, date: Date.now)]))
}
