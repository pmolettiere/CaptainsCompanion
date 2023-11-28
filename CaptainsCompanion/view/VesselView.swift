//
//  VesselView.swift
//  CaptainsCompanion
//
//  Created by Peter Molettiere on 11/27/23.
//

import Foundation
import SwiftUI
import SwiftData

struct VesselView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var isEditing = false
    @State var vessel: Vessel
    
    var body: some View {
        if( isEditing ) {
            VesselDetailEditView(vessel: vessel) {
                HStack() {
                    Spacer()
                    Button("command.vessel.save", systemImage: "square.and.pencil") {
                            isEditing.toggle()
                    }
                }
                .padding()
            }
        } else{
            VesselDetailView(vessel: vessel) {
                Button("command.vessel.save", systemImage: "pencil" ) {
                        isEditing.toggle()
                }
            }
        }
        Spacer()
    }
    
}

#Preview {
    let test = Vessel(
        timestamp: Date(),
        name: "Salacia", model: "53C", make: "Santa Cruz", year: 2004, hin: "SYM5300H504",
        cruisingSpeedValue: 7, cruisingSpeedUnit: .knots,
        fuelConsumptionValue: 4.73, fuelConsumptionUnit: .lph,
        fuelCapacityValue: 89, fuelCapacityUnit: .gallons)
    
    return VesselView(vessel: test)
        .modelContainer(for: Vessel.self, inMemory: true)
}

