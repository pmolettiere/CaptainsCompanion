//
//  ContentView.swift
//  CaptainsCompanion
//
//  Created by Peter Molettiere on 11/21/23.
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

import SwiftUI
import SwiftData

struct VesselListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Vessel.name) private var vessels: [Vessel]
    
    @State private var selection: Vessel.ID?

    fileprivate func selectedVessel() -> Vessel? {
        return vessels.first(where: {$0.id == selection})
    }
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                ForEach(vessels, id: \.self.id) { vessel in
                    NavigationLink(destination: VesselView(vessel: vessel)) {
                        Text(vessel.name)
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button(action: addVessel) {
                        Label("command.vessel.add", systemImage: "plus")
                    }
                }
                ToolbarItem {
                    Button(action: deleteVessel) {
                        Label("command.vessel.delete", systemImage: "minus")
                    }
                    .disabled(selection == nil)
                }
            }
        }
        detail: {
            if selection != nil {
                if let sv = selectedVessel() {
                    VesselView(vessel: sv)
                }
            } else {
                Text("command.vessel.select")
            }
        }
    }

    private func addVessel() {
        withAnimation {
            let newVessel = Vessel(created: Date())
            modelContext.insert(newVessel)
        }
    }
    
    private func deleteVessel() {
        if let dv = selectedVessel() {
            modelContext.delete(dv)
            selection = nil
        }
    }
}

#Preview {
    VesselListView()
        .modelContainer(for:[Vessel.self], inMemory: true)
}
