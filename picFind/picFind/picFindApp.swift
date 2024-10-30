//
//  picFindApp.swift
//  picFind
//
//  Created by Marwan Aziz on 29/10/2024.
//

import SwiftUI
import SwiftData
import AppStorage

@main
struct picFindApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(AppStorage.shared.modelContainer)
    }
}
