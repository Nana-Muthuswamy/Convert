//
//  ContentView.swift
//  Convert
//
//  Created by Narayanan V Muthuswamy on 10/24/20.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTargetUnit = 0
    @State private var selectedDestinationUnit = 0
    @State private var inputValue = ""

    let units = TimeUnit.allValues

    var outputValue: Double {
        guard selectedTargetUnit < units.count, selectedDestinationUnit < units.count else { return 0 }

        return TimeUnit.convert(inputValue, from: units[selectedTargetUnit], to: units[selectedDestinationUnit])
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
