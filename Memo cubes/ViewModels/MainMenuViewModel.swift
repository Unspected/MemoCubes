
import Foundation
import CoreData
import SwiftUI

final class MainMenuViewModel: ObservableObject {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Published var user: User
    @Published var userIsEmpty: Bool = true
    
    private let context: NSManagedObjectContext
    
    init(context: CoreDataService, userName: User? = nil) {
        self.context = context.newContext
        self.user = User(context: self.context)
    }
    
    func checkUserContainer(container: FetchedResults<User>) -> Binding<Bool> {
        if container.isEmpty {
            return Binding(projectedValue: .constant(true))
        } else {
            return Binding(projectedValue: .constant(false))
        }
    }
    
    func saveData() {
        guard context.hasChanges else { return }
        
        do {
            try context.save()
            debugPrint("Success save")
        } catch {
            print("Failed to save the context:", error.localizedDescription)
        }
    }
}
