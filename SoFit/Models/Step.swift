//
//  Step.swift
//  SoFit
//
//  Created by Narayana Wijaya on 07/06/24.
//

import Foundation

struct Step: Identifiable {
    let id = UUID()
    let date: Date
    let count: Int
}

func getMockStepData() -> [Step] {
    let range: [Int] = [0, 1, 2, 3, 4, 5, 6]
    let data = range.map { d in
        return Step(date: Calendar.current.date(byAdding: .day, value: d - 6, to: Date.now)!, count: Int.random(in: 0..<10000))
    }
    return data
}

let stepData = [
    Step(date: Date(), count: 5000),
    Step(date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, count: 3500),
    Step(date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, count: 7100),
    Step(date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!, count: 8000),
    Step(date: Calendar.current.date(byAdding: .day, value: -5, to: Date())!, count: 4000)
]
