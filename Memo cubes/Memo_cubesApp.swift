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
    @AppStorage("isOnboarding") var isOnboarding: Bool = true

    var body: some Scene {
        WindowGroup {
            if isOnboarding {
                OnBoardingView(pages: OnboardingDataModel.models)
            } else {
                //            ContentView()
                //                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                MainMenuView()
            }
        }
    }
}
