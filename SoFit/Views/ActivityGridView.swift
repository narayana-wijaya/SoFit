//
//  ActivityGridView.swift
//  SoFit
//
//  Created by Narayana Wijaya on 08/06/24.
//

import SwiftUI

struct ActivityGridView: View {
    var list: GroupedWorkout!
    
    var body: some View {
        ZStack {
            Color(uiColor: .systemGray6)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Text(list.name)
                        .lineLimit(2)
                    
                    Spacer()
                    
                    Image(list.imageName)
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundStyle(.green)
                }
                .padding(.bottom, 10)
                 
                Spacer()
                
                HStack(alignment: .center) {
                    Image(systemName: "flame.fill")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundStyle(Color.red)
                    Text("\(list.totalCalories) kCal")
                        .font(.system(size: 10))
                        .lineLimit(1)
                    
                    Spacer()
                    
                    if list.totalDistance > 0 {
                        HStack {
                            Image(systemName: "point.topleft.down.to.point.bottomright.curvepath")
                                .resizable()
                                .frame(width: 10, height: 10)
                            Text("\(list.totalDistance) km")
                                .font(.system(size: 10))
                                .lineLimit(1)
                        }
                    }
                }
                
                HStack {
                    Image(systemName: "stopwatch")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundStyle(Color.blue)
                        
                    Text(list.totalDuration.asDurationFormat())
                        .font(.system(size: 10))
                        .lineLimit(1)
                }
                
                HStack {
                    Spacer()
                    Text("\(list.workouts.count) Activities")
                        .font(.system(size: 12))
                        .lineLimit(1)
                        .foregroundStyle(.blue)
                    Image(systemName: "chevron.forward")
                        .resizable()
                        .frame(width: 6, height: 10)
                        .foregroundStyle(Color.blue)
                }
                
            }.padding(10)
        }
    }
}

#Preview {
    ActivityGridView(list: GroupedWorkout(name: "Running", imageName: "Underwater Diving", totalDuration: 100, totalDistance: 1000, totalCalories: 500, workouts: []))
        .frame(width: 150, height: 150)
}
