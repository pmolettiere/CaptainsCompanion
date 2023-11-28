//
//  ContentView.swift
//  CaptainsCompanion
//
//  Created by Peter Molettiere on 11/21/23.
//

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
                    NavigationLink(destination: VesselDetailView(vessel: vessel)) {
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
        }
    }
}

#Preview {
    VesselListView()
        .modelContainer(for:[Vessel.self], inMemory: true)
}
