//
//  VesselDetailEditView.swift
//  CaptainsCompanion
//
//  Created by Peter Molettiere on 11/21/23.
//

import SwiftUI
import SwiftData

struct VesselDetailEditView: View {
    @Environment(\.modelContext) private var modelContext
    @State var vessel: Vessel
    
    var yearFormat: NumberFormatter
    var doubleDecimalFormat: NumberFormatter

    var body: some View {
        let labelWidth: CGFloat = 120;
        List {
            Section(header: Text("Vessel Identification").font(.headline)) {
                HStack {
                    Text("vessel.name.label")
                        .frame(width: labelWidth, height: 25,
                               alignment: Alignment.trailing)
                    TextField("vessel.name.label", text: $vessel.name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                HStack {
                        Text("vessel.make.label")
                        .frame(width: labelWidth, height: 25,
                               alignment: Alignment.trailing)
                        TextField("vessel.make.label", text: $vessel.make)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                HStack {
                        Text("vessel.model.label")
                        .frame(width: labelWidth, height: 25,
                               alignment: Alignment.trailing)
                        TextField("vessel.model.label", text: $vessel.model)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                HStack {
                    Text("vessel.year.label")
                        .frame(width: labelWidth, height: 25,
                               alignment: Alignment.trailing)
                    TextField("vessel.year.label", value: $vessel.year, formatter: yearFormat)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Stepper("vessel.year.label", value: $vessel.year, in: 1800...2024, step: 1)
                        .labelsHidden()
                }
                HStack {
                    Text("vessel.hin.label")
                        .frame(width: labelWidth, height: 25,
                               alignment: Alignment.trailing)
                    TextField("vessel.hin.label", text: $vessel.hin)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
            Section(header: Text("Fuel Range and Speed").font(.headline)) {
                HStack {
                    Text("vessel.cruisingSpeed.label")
                        .frame(width: labelWidth, height: 25,
                               alignment: Alignment.trailing)
                    TextField("vessel.cruisingSpeed.label", value: $vessel.cruisingSpeedValue, formatter: doubleDecimalFormat)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Stepper("vessel.cruisingSpeed.label", value: $vessel.cruisingSpeedValue, in: 0...25, step: 0.1)
                        .labelsHidden()
                    Picker("", selection: $vessel.cruisingSpeedUnit ) {
                        ForEach(Vessel.SpeedUnit.allCases) { unit in
                            Text(unit.label)
                                .tag(unit)
                        }
                    }
                }
                HStack {
                    Text("vessel.fuelConsumption.label")
                        .frame(width: labelWidth, height: 25,
                               alignment: Alignment.trailing)
                    TextField("vessel.fuelConsumption.label", value: $vessel.fuelConsumptionValue, formatter: doubleDecimalFormat)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Stepper("vessel.fuelConsumption.label", value: $vessel.fuelConsumptionValue, in: 0...20, step: 0.01)
                        .labelsHidden()
                    Picker("", selection: $vessel.fuelConsumptionUnit ) {
                        ForEach(Vessel.ConsumptionUnit.allCases) { unit in
                            Text(unit.label)
                                .tag(unit.rawValue)
                                .textCase(.uppercase)
                        }
                    }
                }
                HStack {
                    Text("vessel.fuelCapacity.label")
                        .frame(width: labelWidth, height: 25,
                               alignment: Alignment.trailing)
                    TextField("vessel.fuelCapacity.label", value: $vessel.fuelCapacityValue, formatter: doubleDecimalFormat)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Stepper("vessel.fuelCapacity.label", value: $vessel.fuelCapacityValue, in: 0...20)
                        .labelsHidden()
                    Picker("", selection: $vessel.fuelCapacityUnit ) {
                        ForEach(Vessel.VolumeUnit.allCases) { unit in
                            Text(unit.label)
                                .tag(unit.rawValue)
                        }
                    }
                }
            }
        }
        .padding(EdgeInsets())
    }

    init(vessel: Vessel) {
        self.vessel = vessel
        self.yearFormat = NumberFormatter()
        self.doubleDecimalFormat = NumberFormatter()
        yearFormat.numberStyle = NumberFormatter.Style.none;
        doubleDecimalFormat.numberStyle = NumberFormatter.Style.decimal;
        doubleDecimalFormat.minimumFractionDigits = 2
        doubleDecimalFormat.maximumFractionDigits = 2
    }
}

#Preview {
    VesselDetailEditView(vessel: Vessel(created: Date.now))
        .modelContainer(for: Vessel.self, inMemory: true)
}

