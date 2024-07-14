//
//  Memo_cubesApp.swift
//  Memo cubes
//
//  Created by Pavel Andreev on 7/10/24.
//

import SwiftUI

@main
struct Memo_cubesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            MainMenu()
        }
    }
}
