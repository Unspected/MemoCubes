import CoreData
import Foundation

final class CoreDataService: NSObject, ObservableObject {
    
    static let shared = CoreDataService()
    
    private let container: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        container.viewContext
    }
    
    var newContext: NSManagedObjectContext {
        container.newBackgroundContext()
    }
    
    override init() {
        container = NSPersistentContainer(name: "User")
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
        
    }
    
    
    func save() {
        guard container.viewContext.hasChanges else { return }
        
        do {
            try container.viewContext.save()
        } catch {
            print("Failed to save the context:", error.localizedDescription)
        }
    }
    
    func saveUser(_ name: String, context: NSManagedObjectContext) {
        let newUser = User(context: context)
        newUser.name = name
    }
    
    func getUserName() -> String {
        return container.name
    }
    
}


