//
//  NumberFormatter.swift
//  Finance Tracker
//
//  Created by Nikita Shyshkin on 01/03/2025.
//

import Foundation

struct NumberFormatter {
    static let shared = NumberFormatter()
    
    private init() {}
    
    func format(_ number: Double, decimalPlaces: Int = 2) -> String {
        return String(format: "%.\(decimalPlaces)f", number)
    }
}
