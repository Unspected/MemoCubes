import Foundation
import Combine

protocol GameViewProtocol {
    func fetchCubes() async
    func onTap(cube: CubeModel)
}

final class GameViewModel2: GameViewProtocol {
    
    private let service: GameMemoServiceProtocol
    
    @Published var cubes: [CubeModel] = []
    @Published var errorMessage: Error?
    @Published var disabledAllTouches: Bool = false
    @Published var stepsCount: Int = 0
    
    let player: PlayerServiceProtocol
    
    init(service: GameMemoServiceProtocol, player: PlayerServiceProtocol) {
        self.service = service
        self.player = player
    }
    
    func fetchCubes() async {
        do {
            let fetchedCubes = try await service.fetchCubes()
            try Task.checkCancellation()
            self.cubes = fetchedCubes
        } catch(let error) {
            print(error)
            self.errorMessage = error
        }
    }
    
    func onTap(cube: CubeModel) {
        guard !disabledAllTouches, !cube.open, !cube.disabled else { return }
        player.addCube(cube: cube)
        stepsCount += 1
    }
    
    // MARK: Logic Compare
    private func matchCubes() -> Bool {
        var foundedCubes: [CubeModel] = []
        for cube in player.cubeStorage {
            if let openedCube = cubes.first(where: {$0.id == cube }) {
                foundedCubes.append(openedCube)
            }
        }
        return foundedCubes[0] == foundedCubes[1]
    }
    
    private func openCubeAction(cubeID: CubeModel.ID) {
        if let index = cubes.firstIndex(where: { $0.id == cubeID }) {
            cubes[index].open = true
        }
    }
    
    private func disabledCubeAction(cubeID: CubeModel.ID) {
        if let index = cubes.firstIndex(where: { $0.id == cubeID }) {
            cubes[index].disabled = true
        }
    }
    
}
