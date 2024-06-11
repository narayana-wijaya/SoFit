//
//  StepsView.swift
//  SoFit
//
//  Created by Narayana Wijaya on 06/06/24.
//

import SwiftUI

struct StepsView: View {
    @Environment(HealthKitManager.self) private var manager
    
    var body: some View {
        SevenDaysStepBarChartView(steps: manager.steps)
            .frame(height: 150)
        
        HStack(alignment: .center) {
            HStack(alignment: .lastTextBaseline) {
                Text("\(manager.stepTotal)")
                    .font(.title)
                    .bold()
                
                Text("steps")
                    .font(.footnote)
            }
            Divider()
                .frame(height: 50)
            Image(systemName: "point.topleft.down.to.point.bottomright.curvepath")
                .imageScale(.large)
                .foregroundStyle(Color.gray)
            VStack {
                Text("\(manager.distanceSevenDays)")
                Text("km")
            }
            Divider()
                .frame(height: 50)
            Image(systemName: "flame.fill")
                .imageScale(.large)
                .foregroundStyle(Color.red)
            VStack {
                Text("\(manager.totalCalories)")
                Text("kCal")
            }
        }
    }
}

#Preview {
    StepsView()
        .environment(HealthKitManager())
}
