//
//  ContentView.swift
//  CaptainsCompanion
//
//  Created by Peter Molettiere on 11/21/23.
//

import SwiftUI
import SwiftData

struct VesselView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var vessels: [Vessel]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(vessels) { item in
                    NavigationLink {
                        Text("Item at \(item.created, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.created, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
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
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Vessel(created: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(vessels[index])
            }
        }
    }
}

#Preview {
    VesselView()
        .modelContainer(for: Vessel.self, inMemory: true)
}
