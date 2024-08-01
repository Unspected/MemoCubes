import Foundation

protocol PlayerServiceProtocol {
    var name: String { get set }
    var score: Int { get }
    var cubeStorage: [CubeModel2.ID] { get set }
    func addCube(cube: CubeModel2)
    func cleanCubeStorage()
    
}

final class PlayerService: PlayerServiceProtocol {
    
    var name: String
    var score: Int
    var cubeStorage: [CubeModel2.ID]
    
    init(name: String, score: Int = 0, cubeStorage: [CubeModel2.ID] = []) {
        self.name = name
        self.score = score
        self.cubeStorage = cubeStorage
    }
    
    func addCube(cube: CubeModel2) {
        cubeStorage.append(cube.id)
    }
    
    func cleanCubeStorage() {
        cubeStorage.removeAll()
    }
    
    
    
}
