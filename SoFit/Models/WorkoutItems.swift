//
//  WorkoutItems.swift
//  SoFit
//
//  Created by Narayana Wijaya on 04/06/24.
//

import Foundation

class WorkoutItems: ObservableObject {
    @Published var workoutItems: [Workout] = []
}
