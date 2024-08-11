import Foundation


protocol GameMemoServiceProtocol {
    func fetchCubes() async throws -> [CubeModel]
    func gameOver(cubes: [CubeModel]) -> Bool
    
}

final class GameMemoService: GameMemoServiceProtocol {
    
    private let cubeImages: [String] = ["magic-carpet", "swords", "camel",
                                        "camel-shape", "cactus", "castle",
                                        "genie_lamp", "oil_fabric", "papyrus",
                                        "scorpion", "magic_lamp", "sarcophagus",
                                        "scarab_bug", "snake"]
    
    
    // MARL: GameMemoServiceProtocol
    func fetchCubes() async throws -> [CubeModel] {
        return cubeImages
            .flatMap { [ $0, $0] }
            .shuffled()
            .map({ imageName in
                CubeModel(imageName: imageName)
            })
    }
    
    func gameOver(cubes: [CubeModel]) -> Bool {
        return cubes.count == cubes.map { $0.disabled }.count 
    }
    
}
