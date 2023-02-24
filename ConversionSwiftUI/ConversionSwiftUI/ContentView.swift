//
//  ContentView.swift
//  ConversionSwiftUI
//
//  Created by Arina Levchuk on 24.02.23.
//

import SwiftUI

struct ContentView: View {
//    seconds, minutes, hours, or days
    enum Time: String, CaseIterable {
        case seconds = "Seconds"
        case minutes = "Minutes"
        case hours = "Hours"
        case days = "Days"
    }
    
    private let conversions = Time.allCases
    @State private var selectedConversionForInput: Time = .seconds
    @State private var selectedConversionForOutput: Time = .minutes
    @State private var valueToConvert: Double = 0
    
    var secondsUnit: Double {
        switch selectedConversionForInput {
        case .seconds:
            return valueToConvert
        case .minutes:
            return valueToConvert * 60
        case .hours:
            return valueToConvert * (60 * 60)
        case .days:
            return valueToConvert * (60 * 60 * 24)
        }
    }
    
    private var calculatedValue: Double {
        switch selectedConversionForOutput {
        case .seconds:
            return secondsUnit
        case .minutes:
            return secondsUnit / 60
        case .hours:
            return secondsUnit / (60 * 60)
        case .days:
            return secondsUnit / (60 * 60 * 24)
        }
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select conversion for input", selection: $selectedConversionForInput) {
                        ForEach(conversions, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Select INPUT conversion")
                }
                
                Section {
                    TextField("Enter a number", value: $valueToConvert, format: .number)
                } header: {
                    Text("Value to convert")
                }
                
                Section {
                    Picker("Select conversion for output", selection: $selectedConversionForOutput) {
                        ForEach(conversions, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Select OUTPUT conversion")
                }
                
                Section {
                    Text(calculatedValue, format: .number)
                } header: {
                    Text("Result")
                }
            }
            .foregroundColor(.pink)
            .navigationTitle("Time Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
