//
//  HKWorkoutActivity+Ext.swift
//  SoFit
//
//  Created by Narayana Wijaya on 05/06/24.
//

import Foundation
import HealthKit

extension HKWorkoutActivityType {
    var name: String {
        switch self {
        case .archery: return "Archery"
        case .badminton: return "Badminton"
        case .baseball: return "Baseball"
        case .basketball: return "Basketball"
        case .bowling: return "Bowling"
        case .boxing: return "Boxing"
        case .cardioDance: return "Cardio Dance"
        case .climbing: return "Climbing"
        case .cooldown: return "Cooldown"
        case .coreTraining: return "Core Training"
        case .crossTraining: return "Cross Training"
        case .cycling: return "Cycling"
        case .elliptical: return "Elliptical"
        case .fencing: return "Fencing"
        case .fishing: return "Fishing"
        case .fitnessGaming: return "Fitness Gaming"
        case .functionalStrengthTraining: return "Functional Strength Training"
        case .trackAndField: return "Track and Field"
        case .golf: return "Golf"
        case .gymnastics: return "Gymnastics"
        case .hiking: return "Hiking"
        case .hunting: return "Hunting"
        case .highIntensityIntervalTraining: return "High Intensity Interval Training"
        case .jumpRope: return "Jump Rope"
        case .kickboxing: return "Kick Boxing"
        case .martialArts: return "Martial Arts"
        case .mindAndBody: return "Mind and Body"
        case .pilates: return "Pilates"
        case .rugby: return "Rugby"
        case .rowing: return "Rowing"
        case .running: return "Running"
        case .soccer: return "Soccer"
        case .squash: return "Squash"
        case .stairs: return "Stairs"
        case .swimming: return "Swimming"
        case .stepTraining: return "Step Training"
        case .tennis: return "Tennis"
        case .taiChi: return "Tai Chi"
        case .traditionalStrengthTraining: return "Traditional Strength Training"
        case .underwaterDiving: return "Underwater Diving"
        case .volleyball: return "Volley Ball"
        case .walking: return "Walking"
        case .wrestling: return "Wrestling"
        case .wheelchairRunPace: return "Wheelchair Run Pace"
        case .wheelchairWalkPace: return "Wheelchair Walk Pace"
        case .yoga: return "Yoga"
        default: return "Other"
        }
    }
}
