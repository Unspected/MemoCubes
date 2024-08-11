import Foundation

struct CubeModel: Identifiable, Equatable {
    let id: UUID
    let imageName: String
    var open: Bool
    var disabled: Bool
    
    init(imageName: String) {
           self.id = UUID()
           self.imageName = imageName
           self.open = false
           self.disabled = false
    }
}
