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
    @Query private var vessels: [Vessel]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(vessels) { vessel in
                    NavigationLink {
                        VesselDetailEditView(vessel: vessel)
                    } label: {
                        Text(vessel.name)
                    }
                }
                .onDelete(perform: deleteVessels)
            }
#if os(macOS)
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
#endif
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
                ToolbarItem {
                    Button(action: addItem) {
                        Label("vesselview.add", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("vesselview.select")
        }
    }

    private func addItem() {
        withAnimation {
            let newVessel = Vessel(created: Date())
            modelContext.insert(newVessel)
        }
    }

    private func deleteVessels(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(vessels[index])
            }
        }
    }
}

#Preview {
    VesselListView()
        .modelContainer(for:[Vessel.self], inMemory: true)
}
