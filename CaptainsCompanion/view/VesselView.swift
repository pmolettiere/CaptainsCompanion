//
//  VesselView.swift
//  CaptainsCompanion
//
//  Created by Peter Molettiere on 11/27/23.
//
//    Copyright (C) <2023>  <Peter Molettiere>
//
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with this program.  If not, see <https://www.gnu.org/licenses/>.

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
                    Button {
                            isEditing.toggle()
                    } label: {
//                        Label("command.vessel.save", systemImage: "square.and.pencil")
                        Image(systemName: "square.and.pencil")
                    }
                }
                .padding()
            }
        } else{
            VesselDetailView(vessel: vessel) {
                Button {
                        isEditing.toggle()
                } label: {
//                    Label("command.vessel.save", systemImage: "pencil" )
                    Image(systemName: "pencil")
                }
            }
            Spacer()
        }
    }
    
}

#Preview {
    let test = Vessel(
        uuid: UUID(),
        timestamp: Date(),
        name: "Salacia", model: "53C", make: "Santa Cruz", year: 2004, hin: "SYM5300H504",
        cruisingSpeedValue: 7, cruisingSpeedUnit: .knots,
        fuelConsumptionValue: 4.73, fuelConsumptionUnit: .lph,
        fuelCapacityValue: 89, fuelCapacityUnit: .gallons)
    
    return VesselView(vessel: test)
        .modelContainer(for: Vessel.self, inMemory: true)
}

