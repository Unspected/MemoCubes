import Foundation
@testable import Memo_cubes

class GameViewModelMock: CubesServiceProtocol {
    var selectedCubes: [CubeModel] = []
    
    var finishGameAlert: Bool = false
    var cubes: [CubeModel] = [
        CubeModel(imageName: "ankh"),
        CubeModel(imageName: "ankh"),
        CubeModel(imageName: "pharaoh"),
        CubeModel(imageName: "pharaoh"),
        CubeModel(imageName: "eagle"),
        CubeModel(imageName: "eagle")
    ]
    
    var playerScore: Int = 0
    
    func onTapCube(cube: CubeModel) {
        self.selectedCubes.append(cube)
    }
    
    func matchingCubes(cubes: [CubeModel]) -> Bool {
        guard cubes.count == 2 else { return false }
        
        return cubes[0].imageName == cubes[1].imageName
    }
    
    func increasePlayerScore() {
        playerScore += 1
    }
    
    func getPlayerScore() -> Int {
        return playerScore
    }
    
}
