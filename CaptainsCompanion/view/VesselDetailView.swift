//
//  VesselDetailView.swift
//  CaptainsCompanion
//
//  Created by Peter Molettiere on 11/25/23.
//

import Foundation
import SwiftUI
import SwiftData

struct VesselDetailView<Content>: View where Content: View {
    @Environment(\.modelContext) private var modelContext
    @State var vessel: Vessel
    var content: () -> Content
       
    let intFormat = Format.singleton.intFormat
    let decimalFormat = Format.singleton.floatFormat
            
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("\(vessel.name)").font(.title)
                        content()
                    }
                    Text("\(intFormat.string(for: vessel.year) ?? "") \(vessel.make) \(vessel.model) ")
                    Text(vessel.hin)
                }
                .padding([.bottom])
                VStack(alignment: .leading) {
                    Text("section.header.fuel").bold()
                    HStack(spacing: 2) {
                        Text("vessel.cruisingSpeed.label")
                        Spacer()
                        Text("\(vessel.cruisingSpeedValue, specifier: "%.1f")")
                        Text(vessel.cruisingSpeedUnit.label)
                    }
                    HStack(spacing: 2) {
                        Text("vessel.fuelCapacity.label")
                        Spacer()
                        Text("\(vessel.fuelCapacityValue, specifier: "%.0f")")
                        Text(vessel.fuelCapacityUnit.label)
                    }
                    HStack(spacing: 2) {
                        Text("vessel.fuelConsumption.label")
                        Spacer()
                        Text("\(vessel.fuelConsumptionValue, specifier: "%.2f")")
                        Text(vessel.fuelConsumptionUnit.label)
                    }
                    HStack(spacing: 2) {
                        Text("vessel.range.label")
                        Spacer()
                        Text("\(vessel.range(to: .nm), specifier: "%.2f")")
                        Text(Vessel.DistanceUnit.nm.label)
                    }
                }
            }
        }
    }

    init(vessel: Vessel, @ViewBuilder content: @escaping () -> Content) {
        self.vessel = vessel
        self.content = content
    }
}

// Support optional edit button
extension VesselDetailView where Content == EmptyView {
    init(vessel: Vessel) {
        self.vessel = vessel
        self.content = { EmptyView() }
    }
}

#Preview {
    let test = Vessel(
        timestamp: Date(),
        name: "Salacia", model: "53C", make: "Santa Cruz", year: 2004, hin: "SYM5300H504",
        cruisingSpeedValue: 7, cruisingSpeedUnit: .knots,
        fuelConsumptionValue: 4.73, fuelConsumptionUnit: .lph,
        fuelCapacityValue: 89, fuelCapacityUnit: .gallons)
    
    return VesselDetailView(vessel: test)
            .modelContainer(for: Vessel.self, inMemory: true)
}
