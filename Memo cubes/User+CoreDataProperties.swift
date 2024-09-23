//
//  User+CoreDataProperties.swift
//  Memo cubes
//
//  Created by Pavel Andreev on 8/30/24.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String
    
    static func fetchUser() -> NSFetchRequest<User> {
        let request: NSFetchRequest<User> = fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \User.name, ascending: true)
        ]
        return request
    }

}

extension User : Identifiable {

}
