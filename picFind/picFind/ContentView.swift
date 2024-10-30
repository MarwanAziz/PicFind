//
//  ContentView.swift
//  picFind
//
//  Created by Marwan Aziz on 29/10/2024.
//

import SwiftUI
import SwiftData
import ApiServices
import AppStorage

struct ContentView: View {
    private var items: [Item] = []

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
        .onAppear(perform: {
          Task {
            let apiServices = ApiServicesImp()
            do {
              let images = try await apiServices.searchImages(searchTerm: "mercedes")
              print("images count: \(images.count)")
            } catch {
              print("Error fetching images: \(error)")
            }
          }
        })
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
            }
        }
    }
}

#Preview {
    ContentView()
}
