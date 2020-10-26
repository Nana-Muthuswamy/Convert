//
//  ContentView.swift
//  Convert
//
//  Created by Narayanan V Muthuswamy on 10/24/20.
//

import SwiftUI

enum ConversionType: Int, CaseIterable, CustomStringConvertible {
    case time
    case length

    var description: String {
        switch self {
        case .time:
            return "Time"
        case .length:
            return "Length"
        }
    }
}

struct ContentView: View {
    @State private var selectedConversionType = 0
    @State private var selectedTargetUnit = 0
    @State private var selectedDestinationUnit = 0
    @State private var inputValue = ""

    let timeUnits = TimeUnit.allCases
    let lengthUnits = LengthUnit.allCases

    var unitDescriptions: [String] {
        switch ConversionType.allCases[selectedConversionType] {
        case .time:
            return TimeUnit.allCases.map { $0.description }
        case .length:
            return LengthUnit.allCases.map { $0.description }
        }
    }

    var outputValue: Double {
        switch ConversionType.allCases[selectedConversionType] {
        case .time:
            guard selectedTargetUnit < timeUnits.count, selectedDestinationUnit < timeUnits.count else { return 0 }
            return TimeUnit.convert(inputValue, from: timeUnits[selectedTargetUnit], to: timeUnits[selectedDestinationUnit])
        case .length:
            guard selectedTargetUnit < lengthUnits.count, selectedDestinationUnit < lengthUnits.count else { return 0 }
            return LengthUnit.convert(inputValue, from: lengthUnits[selectedTargetUnit], to: lengthUnits[selectedDestinationUnit])
        }
    }

    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("", selection: $selectedConversionType) {
                        ForEach(0 ..< ConversionType.allCases.count) {
                            Text("\(ConversionType.allCases[$0].description)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())

                    TextField("Input Value", text: $inputValue)
                        .keyboardType(.decimalPad)
                }

                Section (header: Text("From Unit")) {
                    Picker("", selection: $selectedTargetUnit) {
                        ForEach(0 ..< unitDescriptions.count) {
                            Text("\(unitDescriptions[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section (header: Text("To Unit")) {
                    Picker("", selection: $selectedDestinationUnit) {
                        ForEach(0 ..< unitDescriptions.count) {
                            Text("\(unitDescriptions[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section (header: Text("Output")) {
                    Text("\(outputValue, specifier: "%.2f")")
                }
            }
            .navigationTitle("Unit Conversion")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
