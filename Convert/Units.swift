//
//  Units.swift
//  Convert
//
//  Created by Narayanan V Muthuswamy on 10/24/20.
//

import Foundation

protocol Measurable: CustomStringConvertible, CaseIterable {}

enum TimeUnit: Measurable {
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

enum LengthUnit: Measurable {
    case meters
    case feet
    case yards
    case miles

    var description: String {
        switch self {
        case .meters:
            return "Meters"
        case .feet:
            return "Feet"
        case .yards:
            return "Yards"
        case .miles:
            return "Miles"
        }
    }

    static func convert(_ inputValue: String, from targetUnit: LengthUnit, to destinationUnit: LengthUnit) -> Double {
        guard let input = Double(inputValue) else { return 0 }

        let inputInMeters = LengthUnit.meters(input, from: targetUnit)

        switch destinationUnit {
        case .meters:
            return inputInMeters
        case .feet:
            return inputInMeters / 0.3048
        case .yards:
            return inputInMeters / 0.9144
        case .miles:
            return inputInMeters / 1609.34
        }
    }

    static private func meters(_ inputValue: Double, from unit: LengthUnit) -> Double {
        switch unit {
        case .meters:
            return inputValue
        case .feet:
            return inputValue * 0.3048
        case .yards:
            return inputValue * 0.9144
        case .miles:
            return inputValue * 1609.34
        }
    }
}

