//
//  HealthKitManager.swift
//  SoFit
//
//  Created by Narayana Wijaya on 06/06/24.
//

import Foundation
import HealthKit

enum HealthKitError: Error {
    case healthDataNotAvailable
}

@Observable
class HealthKitManager {
    
    var healthStore: HKHealthStore?
    var hkError: Error?
    
    var steps: [Step] = []
    var stepTotal: Int = 0
    var totalCalories: Int = 0
    var distanceSevenDays: Int = 0
    var workoutItems: [Workout] = []
    
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
            requestAuth()
        } else {
            hkError = HealthKitError.healthDataNotAvailable
        }
    }
    
    func requestAuth() {
        guard let healthStore = healthStore else { return }
        
        let steps = HKQuantityType(.stepCount)
        let calories = HKQuantityType(.activeEnergyBurned)
        let distance = HKQuantityType(.distanceWalkingRunning)
        let workout = HKObjectType.workoutType()
        
        let healthTypes: Set = [steps, calories, distance, workout]
        Task {
            do {
                try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
            } catch {
                hkError = error
            }
        }
    }
    
    func calculateSteps() async throws {
        guard let healthStore = healthStore else { return }
        
        guard let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount) else { return }
        
        steps.removeAll()
        stepTotal = 0
        
        let calendar = Calendar.current
        let startDate = calendar.date(byAdding: .day, value: -7, to: Date.now)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date.now, options: .strictStartDate)
        let stepsSevenDays = HKSamplePredicate.quantitySample(type: stepType, predicate: predicate)
        
        let sumOfStepsQuery = HKStatisticsCollectionQueryDescriptor(
            predicate: stepsSevenDays,
            options: .cumulativeSum,
            anchorDate: Date.now,
            intervalComponents: DateComponents(day: 1)
        )
        
        let stepCount = try await sumOfStepsQuery.result(for: healthStore)
        
        guard let startDate = startDate else { return }
        
        stepCount.enumerateStatistics(from: startDate, to: Date.now) { stat, stop in
            let count = stat.sumQuantity()?.doubleValue(for: .count())
            let step = Step(date: stat.startDate, count: Int(count ?? 0))
            if step.count > 0 {
                self.stepTotal += Int(count ?? 0)
                self.steps.append(step)
            }
        }
    }
    
    func fetchCaloryData() {
        guard let healthStore = healthStore else { return }
        
        let calories = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
        let calendar = Calendar.current
        let now = Date()
        let sevenDayBefore = calendar.date(byAdding: .day, value: -7, to: now)
        let predicate = HKQuery.predicateForSamples(withStart: sevenDayBefore, end: now, options: .strictStartDate)
        let query = HKStatisticsQuery(quantityType: calories, quantitySamplePredicate: predicate, options: .cumulativeSum) { query, result, error in
            if let error {
                print("Error fetching  records for steps: \(error.localizedDescription)")
                return
            }
            
            guard let result = result else {
                print("No step count data available for the specific predicate")
                return
            }
            DispatchQueue.main.async {
                if let sum = result.sumQuantity() {
                    let cal = Int(sum.doubleValue(for: .kilocalorie()))
                    self.totalCalories = cal
                } else {
                    self.totalCalories = 0
                }
            }
        }
        healthStore.execute(query)
    }
    
    func fetchDistance() {
        guard let healthStore = healthStore else { return }
        
        let distance = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
        let calendar = Calendar.current
        let now = Date()
        let sevenDayBefore = calendar.date(byAdding: .day, value: -7, to: now)
        let predicate = HKQuery.predicateForSamples(withStart: sevenDayBefore, end: now, options: .strictStartDate)
        let query = HKStatisticsQuery(quantityType: distance, quantitySamplePredicate: predicate, options: .cumulativeSum) { query, result, error in
            if let error {
                print("Error fetching  records for steps: \(error.localizedDescription)")
                return
            }
            
            guard let result = result else {
                print("No step count data available for the specific predicate")
                return
            }
            DispatchQueue.main.async {
                if let sum = result.sumQuantity() {
                    let distance = sum.doubleValue(for: .meter())
                    self.distanceSevenDays = Int(distance/1000)
                } else {
                    self.distanceSevenDays = 0
                }
            }
        }
        healthStore.execute(query)
    }
    
    func readWorkouts() {
        guard let healthStore = healthStore else { return }
        
        workoutItems.removeAll()
        
        let predicate = HKQuery.predicateForWorkouts(with: .greaterThan, duration: 1)
        
        healthStore.execute(HKSampleQuery(sampleType: .workoutType(), predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [.init(keyPath: \HKSample.startDate, ascending: false)], resultsHandler: { query, samples, error in
            
            if (error != nil) {
                return
            }
            
            guard let samples = samples else {
                fatalError("Invalid state : This fails if there is an error")
            }
            
            guard let workout = samples as? [HKWorkout] else {
                return
            }
            
            var id = 0
            for activity in workout {
                var workoutCalories: Int = 0
                var workoutActivityName: String = ""
                var workoutDistance: Double = 0.0
                
                if let value = activity.totalEnergyBurned {
                    workoutCalories = Int(value.doubleValue(for: HKUnit.kilocalorie()))
                }
                
                workoutActivityName = activity.workoutActivityType.name
                
                if let value = activity.totalDistance {
                    workoutDistance = value.doubleValue(for: HKUnit.meter())
                }
                
                let w = Workout(name: workoutActivityName, imageName: workoutActivityName, duration: activity.duration, distance: Int(workoutDistance/1000), calories: workoutCalories, date: activity.endDate)
                
                id = id+1
                DispatchQueue.main.async {
                    self.workoutItems.append(w)
                }
            }
        }))
    }
}
