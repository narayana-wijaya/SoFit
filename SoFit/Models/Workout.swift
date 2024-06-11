//
//  Workout.swift
//  SoFit
//
//  Created by Narayana Wijaya on 04/06/24.
//

import Foundation

struct Workout: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let duration: Double
    let distance: Int
    let calories: Int
    let date: Date
}

struct GroupedWorkout: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let totalDuration: Double
    let totalDistance: Int
    let totalCalories: Int
    let workouts: [Workout]
}
