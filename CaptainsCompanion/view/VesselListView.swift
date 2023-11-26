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
    @State private var selectedVessel: Vessel?

    var body: some View {
        NavigationSplitView {
            List (vessels, selection: $selection) { vessel in
                NavigationLink(destination: VesselDetailEditView(vessel: vessel)) {
                    VesselDetailView(vessel: vessel)
                }
            }
            .onChange(of: selection) {
                if let v = selection {
                    print("VesselListView selection changed to \(v)")
                    if let sv = vessels.first(where: {$0.id == selection}) {
                        selectedVessel = sv;
                        print("VesselListView selectedVessel set to \(sv.name)")
                    }
                } else {
                    print("VesselListView selection changed to nil")
                }
            }
            .toolbar {
                ToolbarItem {
                    Button(action: addVessel) {
                        Label("vesselview.add", systemImage: "plus")
                    }
                }
                ToolbarItem {
                    Button(action: deleteVessel) {
                        Label("vesselview.delete", systemImage: "minus")
                    }
                }
            }
        } detail: {
            if let vessel = selectedVessel {
                VesselDetailEditView(vessel: vessel)
            } else {
                Text("vesselview.select")
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
        if let dv = selectedVessel {
            print("VesselListView.deleteVessel deleting \(dv.name)")
            modelContext.delete(dv)
        }
    }
}

#Preview {
    VesselListView()
        .modelContainer(for:[Vessel.self], inMemory: true)
}
