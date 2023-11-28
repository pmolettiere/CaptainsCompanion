//
//  VesselDetailEditView.swift
//  CaptainsCompanion
//
//  Created by Peter Molettiere on 11/21/23.
//

import SwiftUI
import SwiftData

struct VesselDetailEditView<Content>: View, Equatable where Content: View {
    static func == (lhs: VesselDetailEditView, rhs: VesselDetailEditView) -> Bool {
        lhs.vessel.id == rhs.vessel.id
    }
    
    @Environment(\.modelContext) private var modelContext
    @State var vessel: Vessel
    var content: () -> Content
    
    var body: some View {
        let labelWidth: CGFloat = 120;
        List {
            Section(header: Text("section.header.id").font(.headline)) {
                StringEditor(label: "vessel.name.label", field: $vessel.name, width: labelWidth)
                StringEditor(label: "vessel.make.label", field: $vessel.make, width: labelWidth)
                StringEditor(label: "vessel.model.label", field: $vessel.model, width: labelWidth)
                IntEditor(label: "vessel.year.label", field: $vessel.year, width: labelWidth, range: 1800...2030)
                StringEditor(label: "vessel.hin.label", field: $vessel.hin, width: labelWidth)
            }
            Section(header: Text("section.header.fuel").font(.headline)) {
                SpeedUnitEditor(label: "vessel.cruisingSpeed.label", value: $vessel.cruisingSpeedValue, unit: $vessel.cruisingSpeedUnit, width: labelWidth, range: 0...25, step: 0.1) {
                        ForEach(Vessel.SpeedUnit.allCases) { unit in
                            Text(unit.label)
                                .tag(unit)
                        }
                }
                ConsumptionUnitEditor(label: "vessel.fuelConsumption.label", value: $vessel.fuelConsumptionValue, unit: $vessel.fuelConsumptionUnit, width: labelWidth, range: 0...20, step: 0.01) {
                        ForEach(Vessel.ConsumptionUnit.allCases) { unit in
                            Text(unit.label)
                                .tag(unit.rawValue)
                                .textCase(.uppercase)
                        }
                }
                VolumeUnitEditor(label: "vessel.fuelCapacity.label", value: $vessel.fuelCapacityValue, unit: $vessel.fuelCapacityUnit, width: labelWidth, range: 0...5000, step: 1) {
                        ForEach(Vessel.VolumeUnit.allCases) { unit in
                            Text(unit.label)
                                .tag(unit.rawValue)
                        }
                }
            }
            content()
        }
        .padding(EdgeInsets())
    }

    init(vessel: Vessel, @ViewBuilder content: @escaping () -> Content) {
        self.vessel = vessel
        self.content = content
    }
}

// Support optional edit button
extension VesselDetailEditView where Content == EmptyView {
    init(vessel: Vessel) {
        self.vessel = vessel
        self.content = { EmptyView() }
    }
}

#Preview {
    VesselDetailEditView(vessel: Vessel(created: Date.now))
        .modelContainer(for: Vessel.self, inMemory: true)
}


struct StringEditor: View {
    let label: LocalizedStringKey
    let field: Binding<String>
    let width: CGFloat
    
    var body: some View {
        HStack {
            Text(label)
                .frame(width: width, height: 25,
                       alignment: Alignment.trailing)
            TextField(label, text: field)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

struct IntEditor: View {
    let label: LocalizedStringKey
    let field: Binding<Int>
    let width: CGFloat
    let range: ClosedRange<Int>
    
    var body: some View {
        HStack {
            Text(label)
                .frame(width: width, height: 25,
                       alignment: Alignment.trailing)
            TextField(label, value: field, formatter: Format.singleton.intFormat)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Stepper(label, value: field, in: range, step: 1)
                .labelsHidden()
        }
    }
}

struct SpeedUnitEditor: View {
    let label: LocalizedStringKey
    let value: Binding<Float>
    let unit: Binding<Vessel.SpeedUnit>
    let width: CGFloat
    let range: ClosedRange<Float>
    let step: Float
    @ViewBuilder
    let cases: () -> any View

    var body: some View {
        HStack {
            Text(label)
                .frame(width: width, height: 25,
                       alignment: Alignment.trailing)
            TextField(label, value: value, formatter: Format.singleton.floatFormat)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Stepper(label, value: value, in: range, step: step)
                .labelsHidden()
            Picker("", selection: unit ) {
                AnyView(cases())
            }
        }
    }
}

struct ConsumptionUnitEditor: View {
    let label: LocalizedStringKey
    let value: Binding<Float>
    let unit: Binding<Vessel.ConsumptionUnit>
    let width: CGFloat
    let range: ClosedRange<Float>
    let step: Float
    @ViewBuilder
    let cases: () -> any View

    var body: some View {
        HStack {
            Text(label)
                .frame(width: width, height: 25,
                       alignment: Alignment.trailing)
            TextField(label, value: value, formatter: Format.singleton.floatFormat)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Stepper(label, value: value, in: range, step: step)
                .labelsHidden()
            Picker("", selection: unit ) {
                AnyView(cases())
            }
        }
    }
}

struct VolumeUnitEditor: View {
    let label: LocalizedStringKey
    let value: Binding<Float>
    let unit: Binding<Vessel.VolumeUnit>
    let width: CGFloat
    let range: ClosedRange<Float>
    let step: Float
    @ViewBuilder
    let cases: () -> any View

    var body: some View {
        HStack {
            Text(label)
                .frame(width: width, height: 25,
                       alignment: Alignment.trailing)
            TextField(label, value: value, formatter: Format.singleton.intFormat)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Stepper(label, value: value, in: range, step: step)
                .labelsHidden()
            Picker("", selection: unit ) {
                AnyView(cases())
            }
        }
    }
}
