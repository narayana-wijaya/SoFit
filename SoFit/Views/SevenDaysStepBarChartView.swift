//
//  SevenDaysStepBarChartView.swift
//  SoFit
//
//  Created by Narayana Wijaya on 06/06/24.
//

import SwiftUI
import Charts

struct SevenDaysStepBarChartView: View {
    let steps: [Step]
    
    var body: some View {
        Chart(steps) { step in
            BarMark(
                x: .value("Date", step.date, unit: .day),
                y: .value("Count", step.count)
            )
            .cornerRadius(10, style: .circular)
            .foregroundStyle(isUnderTarget(step.count) ? Color.red : Color.green)
        }
        .chartXScale(domain: Calendar.current.date(byAdding: .day, value: -6, to: Date.now)!...Date.now,
                     range: .plotDimension(startPadding: 10, endPadding: 10))
    }
}

#Preview {
    return SevenDaysStepBarChartView(steps: getMockStepData())
}


