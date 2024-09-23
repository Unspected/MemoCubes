import SwiftUI


enum DI {
    static let dataService = CoreDataService.shared
    static let mainViewModel = MainMenuViewModel(context: dataService)
}

@main
struct Memo_cubesApp: App {
    
    
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    @StateObject var mainMenuViewModel = DI.mainViewModel
    

    var body: some Scene {
        
        
        WindowGroup {
            if isOnboarding {
                OnBoardingView(pages: OnboardingDataModel.models)
            } else {
                MainMenuView(viewModel: mainMenuViewModel)
                    .environment(\.managedObjectContext, DI.dataService.viewContext)
            }
        }
    }
}
