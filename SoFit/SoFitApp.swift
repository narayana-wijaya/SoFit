//
//  SoFitApp.swift
//  SoFit
//
//  Created by Narayana Wijaya on 04/06/24.
//

import SwiftUI
import SwiftData

@main
struct SoFitApp: App {
    @State var manager = HealthKitManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }.environment(manager)
    }
}
