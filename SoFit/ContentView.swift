//
//  ContentView.swift
//  SoFit
//
//  Created by Narayana Wijaya on 04/06/24.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    @Environment(HealthKitManager.self) private var manager
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Steps")
                        .font(.title2)
                    StepsView()
                }
                Divider()
                    .padding(.vertical)
                VStack(alignment: .leading) {
                    Text("Activity Summary")
                        .font(.title2)
                    LazyVGrid(columns: Array(repeating: GridItem(spacing: 8), count: 2)) {
                        ForEach(groupedWorkout) { item in
                            NavigationLink(value: item) {
                                ActivityGridView(list: item)
                            }.buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Overview")
            .navigationDestination(for: GroupedWorkout.self, destination: { item in
                WorkoutGroupListScreen(workouts: item)
            })
            .task {
                do {
                    try await manager.calculateSteps()
                } catch {
                    print(error)
                }
            }
            .onAppear {
                self.manager.fetchCaloryData()
                self.manager.fetchDistance()
                self.manager.readWorkouts()
            }
        }
        
    }
    
    private var groupedWorkout: [GroupedWorkout] {
        let groupDict = Dictionary(grouping: manager.workoutItems, by: {$0.name} )
        let groupedWorkout = groupDict.map { (name, list) in
            let totalDuration = list.map { $0.duration }.reduce(0) { partialResult, val in
                return partialResult + val
            }
            let totalDistance = list.map { $0.distance }.reduce(0) { partialResult, val in
                return partialResult + val
            }
            let totalCalories = list.map { $0.calories }.reduce(0) { partialResult, val in
                return partialResult + val
            }
            return GroupedWorkout(name: name, imageName: name, totalDuration: totalDuration, totalDistance: totalDistance, totalCalories: totalCalories, workouts: list)
        }
        return groupedWorkout.sorted { gr1, gr2 in
            gr1.workouts.count > gr2.workouts.count
        }
    }
}

#Preview {
    ContentView()
        .environment(HealthKitManager())
}
