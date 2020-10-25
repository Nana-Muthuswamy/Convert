//
//  Units.swift
//  Convert
//
//  Created by Narayanan V Muthuswamy on 10/24/20.
//

import Foundation

enum TimeUnit: Int, CustomStringConvertible, CaseIterable {
    case seconds
    case minutes
    case hours
    case days

    var description: String {
        switch self {
        case .seconds:
            return "Seconds"
        case .minutes:
            return "Minutes"
        case .hours:
            return "Hours"
        case .days:
            return "Days"
        }
    }

    static var allValues: [TimeUnit] {
        return [.seconds, .minutes, .hours, .days]
    }

    static func convert(_ inputValue: String, from targetUnit: TimeUnit, to destinationUnit: TimeUnit) -> Double {
        guard let input = Double(inputValue) else { return 0 }

        let inputInSeconds = TimeUnit.seconds(input, from: targetUnit)

        switch destinationUnit {
        case .seconds:
            return inputInSeconds
        case .minutes:
            return inputInSeconds / 60
        case .hours:
            return inputInSeconds / (60 * 60)
        case .days:
            return inputInSeconds / (60 * 60 * 24)
        }
    }

    static private func seconds(_ inputValue: Double, from unit: TimeUnit) -> Double {
        switch unit {
        case .seconds:
            return inputValue
        case .minutes:
            return inputValue * 60
        case .hours:
            return inputValue * 60 * 60
        case .days:
            return inputValue * 60 * 60 * 24
        }
    }
}
