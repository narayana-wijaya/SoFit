//
//  Double+Ext.swift
//  SoFit
//
//  Created by Narayana Wijaya on 05/06/24.
//

import Foundation

extension Double {
    func asDurationFormat(style: DateComponentsFormatter.UnitsStyle = .short) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second, .nanosecond]
        formatter.unitsStyle = style
        return formatter.string(from: self) ?? ""
    }
}
