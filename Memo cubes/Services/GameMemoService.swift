import Foundation

struct CubeModel2: Identifiable, Equatable {
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

protocol GameMemoServiceProtocol {
    func fetchCubes() async throws -> [CubeModel2]
    func gameOver(cubes: [CubeModel2]) -> Bool
    
}

final class GameMemoService: GameMemoServiceProtocol {
    
    private let cubeImages: [String] = ["magic-carpet", "swords", "camel",
                                        "camel-shape", "cactus", "castle",
                                        "genie_lamp", "oil_fabric", "papyrus",
                                        "scorpion", "magic_lamp", "sarcophagus",
                                        "scarab_bug", "snake"]
    
    
    // MARL: GameMemoServiceProtocol
    func fetchCubes() async throws -> [CubeModel2] {
        return cubeImages
            .flatMap { [ $0, $0] }
            .shuffled()
            .map({ imageName in
                CubeModel2(imageName: imageName)
            })
    }
    
    func gameOver(cubes: [CubeModel2]) -> Bool {
        return cubes.count == cubes.map { $0.disabled }.count 
    }
    
}
