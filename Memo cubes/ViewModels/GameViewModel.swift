import Foundation
import Combine
import CoreData

actor TaskManager {
    
    func performWithDelay(seconds: Int = 1, _ callback: @escaping () -> Void) async {
        try? await Task.sleep(for:.seconds(seconds))
        DispatchQueue.main.async {
            callback()
        }
    }
}
// add comment
// add comment2
// add comment 3
// add new commen 4

@MainActor
protocol CubesServiceProtocol {
    func onTapCube(cube: CubeModel)
    func matchingCubes(cubes: [CubeModel]) -> Bool
    var cubes: [CubeModel] { get }
    var playerScore: Int { get set }
    var selectedCubes: [CubeModel] { get }
    var finishGameAlert: Bool { get }
    
}

@MainActor
protocol OpponentServiceProtocol {
    func perfectMatchCubesAI() async
    func openRandomCubesAI()
    func foundedMatchCubes(for cubes: [CubeModel]) async
    var selectedCubesOpponent: [CubeModel] { get }
    var opponentScore: Int { get }
}

@MainActor
final class GameViewModel: ObservableObject, CubesServiceProtocol, OpponentServiceProtocol {
    
    
    private let taskManager = TaskManager()
    private let cubeImages: [String] = ["magic-carpet", "swords", "camel",
                                        "camel-shape", "cactus", "castle",
                                        "genie_lamp", "oil_fabric", "papyrus",
                                        "scorpion", "magic_lamp", "sarcophagus",
                                        "scarab_bug", "snake"]
    
    // @Published var gameDifficulty: Int = 0 where is 0 it's hard and 4 easy
    @Published var opponentScore: Int = 0
    @Published var playerScore: Int = 0
    
    @Published var selectedCubes: [CubeModel] = []
    @Published var selectedCubesOpponent: [CubeModel] = []
    @Published var cubes: [CubeModel] = []
    @Published var finishGameAlert: Bool = false
    
    @Published
    private(set)var opened: Set<CubeModel.ID> = []
    
    @Published
    private(set) var disabled: Set<CubeModel.ID> = []
    @Published var touchesDisabled: Bool = false
    @Published var blockAllField: Bool = false
    
    let opponentName: String = "PC"
    private var stepsCount: Int = 0
    
    init() {
        shuffleGame()
    }
    
    func onTapCube(cube: CubeModel) {
        guard !touchesDisabled, !disabled.contains(cube.id) else {
            return
        }
        opened.insert(cube.id)
        selectedCubes.append(cube)
        checkSelection()
    }
    
    // MARK: - init cubes list with pair
    private func shuffleGame() {
        cubes = cubeImages
            .flatMap { [ $0, $0] }
            .shuffled()
            .map({ imageName in
                CubeModel(imageName: imageName)
            })
    }
    
    private func checkGameIsOver() {
        if opened.count == cubes.count {
            self.touchesDisabled = false
            self.finishGameAlert = true
        }
    }
    
    func prepareGameFieldForNewGame() {
        opened.removeAll()
        disabled.removeAll()
        shuffleGame()
        self.finishGameAlert = false
        self.stepsCount = 0
        self.playerScore = 0
        self.opponentScore = 0
    }
    
    private func checkSelection() {
        guard selectedCubes.count == 2 else {
            return
        }
        stepsCount += 1 // step count for move your opponent
        touchesDisabled = true // disabled whole screen for touch
        checkGameIsOver()
        
        if matchingCubes(cubes: selectedCubes) {
            playerScore += 1
            selectedCubes.forEach { cube in
                    disabled.insert(cube.id)
                }
            selectedCubes.removeAll()
//            print("ход противника после совпадения")
            Task(priority: .high) {
                try await Task.sleep(for: .seconds(1))
                
                await taskManager.performWithDelay {
                    self.actionMoveOpponent()
                }
            }
            
        } else {
            Task {
//                print("закрывает кубики")
                await taskManager.performWithDelay {
                    self.selectedCubes.forEach { cube in
                        self.opened.remove(cube.id)
                    }
                    self.selectedCubes.removeAll()
//                    print("кубики удаленны из выбранных")
                }
                
                try await Task.sleep(for: .seconds(1))
//                print("Ход противника")
                self.actionMoveOpponent()
            }
            
        }
    }
    
    private func checkIfWon() {
        if opened.count == cubes.count {
            opened.removeAll()
            disabled.removeAll()
            shuffleGame()
        }
    }
    
    // MARK: AI LOGIC WORK
    
    // turn AI found match cubes with 100%
    func perfectMatchCubesAI() {
        let filteredCubes = cubes.filter { !disabled.contains($0.id) }
        guard let openRandomCube = filteredCubes.randomElement(),
                !disabled.contains(openRandomCube.id),
              disabled.count >= (disabled.count - 2) else {
            return
        }
        
        let foundedPair = cubes.filter { $0.imageName == openRandomCube.imageName }
        Task {
            await foundedMatchCubes(for: foundedPair)
            
            checkGameIsOver()
        }
    }
    
    func foundedMatchCubes(for cubes: [CubeModel]) async {
        Task {
            for cube in cubes {
                self.opened.insert(cube.id)
                self.disabled.insert(cube.id)
                try await Task.sleep(for: .seconds(1))
            }
            self.opponentScore += 1
            self.touchesDisabled = false
        }
    }
    
    
    // TODO : Исправить алгоритм здесь
    private func generateRandomCubesForOpen() -> [CubeModel] {
        var randomCubes: [CubeModel] = []
        let filteredCubes = cubes.filter { !disabled.contains($0.id) }
        while randomCubes.count != 2 {
            if let randomCube = filteredCubes.randomElement(),
               let randomCube2 = filteredCubes.randomElement(),
               !disabled.contains(randomCube.id),
               !disabled.contains(randomCube2.id),
               disabled.count >= (disabled.count - 2) {
        
                if randomCube != randomCube2 {
                    randomCubes.append(randomCube)
                    randomCubes.append(randomCube2)
                }
            }
        }
        return randomCubes
    }
    
    // MARK: - open random pair of cube and compare them
    func openRandomCubesAI() {
            let foundedPair = generateRandomCubesForOpen()
            Task {
                if matchingCubes(cubes: foundedPair) {
                    await foundedMatchCubes(for: foundedPair)
                    checkGameIsOver()
                } else {
                    delayOpenedAndClose(for: foundedPair)
                    checkGameIsOver()
                }
        }
    }
        
    // move open and close cubes when AI turn
    func delayOpenedAndClose(for cubes: [CubeModel])  {
        Task {
            for cube in cubes {
                self.opened.insert(cube.id)
                try await Task.sleep(for: .seconds(1))
            }
            
            for cube in cubes {
                self.opened.remove(cube.id)
                try await Task.sleep(for: .seconds(1))
            }
            
            self.touchesDisabled = false
        }
    }
    
    func matchingCubes(cubes: [CubeModel]) -> Bool {
        return cubes[0].imageName == cubes[1].imageName
    }
        
    // MARK: - combine working on AI move
    private func actionMoveOpponent() {
        // каждые 3 ход противника он угадывает со 100% вероятностью
        if stepsCount % 3 == 0 {
           perfectMatchCubesAI()
            
        } else {
            openRandomCubesAI()
        }
    }
}


