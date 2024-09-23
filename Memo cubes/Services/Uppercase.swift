

import Foundation
import SwiftUI

@propertyWrapper
struct Uppercase {
    
    var wrappedValue: String {
        didSet { wrappedValue = wrappedValue.uppercased()
        }
    }
    
    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue.uppercased()
    }
}

