//
//  NumberFormatter.swift
//  getirFinalProject
//
//  Created by Okan Aslan on 23.04.2024.
//

import Foundation

class NumberFormatterUtility {
    static func formatNumber(_ number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.decimalSeparator = ","
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2

        return formatter.string(from: NSNumber(value: number)) ?? ""
    }
}
