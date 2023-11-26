//
//  VesselDetailView.swift
//  CaptainsCompanion
//
//  Created by Peter Molettiere on 11/25/23.
//

import Foundation
import SwiftUI
import SwiftData

struct VesselDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @State var vessel: Vessel
    
    let intFormat = Format.singleton.intFormat
        
    var body: some View {
        Text("\(vessel.name): \(intFormat.string(for: vessel.year) ?? "") \(vessel.make) \(vessel.model) ")
            .fixedSize()
            .padding()
    }
    
    init(vessel: Vessel) {
        self.vessel = vessel
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

