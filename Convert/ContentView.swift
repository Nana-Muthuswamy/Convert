//
//  ContentView.swift
//  Convert
//
//  Created by Narayanan V Muthuswamy on 10/24/20.
//

import SwiftUI

enum TimeUnits: Int, CustomStringConvertible, CaseIterable {
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

    static var allValues: [TimeUnits] {
        return [.seconds, .minutes, .hours, .days]
    }
}

struct ContentView: View {
    @State private var selectedTargetUnit = 0
    @State private var selectedDestinationUnit = 0
    @State private var inputValue = ""

    let units = TimeUnits.allValues

    var targetUnitInSeconds: Double {
        guard let input = Double(inputValue) else { return 0 }
        guard selectedTargetUnit < units.count else { return 0 }

        switch units[selectedTargetUnit] {
        case .seconds:
            return input
        case .minutes:
            return input * 60
        case .hours:
            return input * 60 * 60
        case .days:
            return input * 60 * 60 * 24
        }
    }

    private var outputValue: Double {
        guard selectedTargetUnit < units.count else { return 0 }

        switch units[selectedDestinationUnit] {
        case .seconds:
            return targetUnitInSeconds
        case .minutes:
            return targetUnitInSeconds / 60
        case .hours:
            return targetUnitInSeconds / (60 * 60)
        case .days:
            return targetUnitInSeconds / (60 * 60 * 24)
        }
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Input Value", text: $inputValue)
                        .keyboardType(.decimalPad)
                }

                Section (header: Text("From Unit")) {
                    Picker("", selection: $selectedTargetUnit) {
                        ForEach(0 ..< units.count) {
                            Text("\(units[$0].description)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section (header: Text("To Unit")) {
                    Picker("", selection: $selectedDestinationUnit) {
                        ForEach(0 ..< units.count) {
                            Text("\(units[$0].description)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section (header: Text("Output")) {
                    Text("\(outputValue, specifier: "%.2f")")
                }
            }
            .navigationTitle("Time Conversion")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
