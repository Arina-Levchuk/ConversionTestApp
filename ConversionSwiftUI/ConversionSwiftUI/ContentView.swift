//
//  ContentView.swift
//  ConversionSwiftUI
//
//  Created by Arina Levchuk on 24.02.23.
//

import SwiftUI

struct ContentView: View {
    enum Time: String, CaseIterable {
        case seconds = "Seconds"
        case minutes = "Minutes"
        case hours = "Hours"
        case days = "Days"
        
        func getUnitForConversion() -> UnitDuration {
            switch self {
            case .seconds:
                return UnitDuration.seconds
            case .minutes:
                return UnitDuration.minutes
            case .hours:
                return UnitDuration.hours
            case .days:
                return UnitDuration.days
            }
        }
    }
    
    @FocusState private var valueIsFocused: Bool
    
    private let conversions = Time.allCases
    @State private var selectedConversionForInput: Time = .seconds
    @State private var selectedConversionForOutput: Time = .minutes
    
    @State private var inputtedValue: Double = 0

    private var calculatedValue: Double {
        let valueToConvert = Measurement(value: inputtedValue, unit: selectedConversionForInput.getUnitForConversion())
        let converted = valueToConvert.converted(to: selectedConversionForOutput.getUnitForConversion())
        return converted.value
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
                    TextField("Enter a number", value: $inputtedValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($valueIsFocused)
                        .foregroundColor(.primary)
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
                        .foregroundColor(.primary)
                } header: {
                    Text("Result")
                }
            }
            .foregroundColor(.pink)
            .navigationTitle("Time Converter")
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        valueIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}

extension UnitDuration {
    static let SecondsPerDay: Double = 86_400
    
    static let days = UnitDuration(symbol: "days", converter: UnitConverterLinear(coefficient: SecondsPerDay))
}
