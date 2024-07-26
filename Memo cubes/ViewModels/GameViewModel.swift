import Foundation
import Combine

struct CubeModel: Identifiable, Equatable {
    let id: UUID
    let imageName: String
    
    init(imageName: String) {
           self.id = UUID()
           self.imageName = imageName
    }
}

@MainActor
protocol CubesServiceProtocol {
    func onTapCube(cube: CubeModel)
    func matchingCubes(cubes: [CubeModel]) -> Bool
    func foundedMatchCubes(for cubes: [CubeModel]) async throws
}

@MainActor
protocol OpponentServiceProtocol {
    func perfectMatchCubesAI()
    func openRandomCubesAI()
}

final class GameViewModel: ObservableObject, CubesServiceProtocol, OpponentServiceProtocol {
   
    private let cubeImages: [String] = ["magic-carpet", "swords", "camel",
                                        "camel-shape", "cactus", "castle",
                                        "genie_lamp", "oil_fabric", "papyrus",
                                        "scorpion", "magic_lamp", "sarcophagus",
                                        "scarab_bug", "snake"]
    // TODO
    // @Published var gameDifficulty: Int = 0 where is 0 it's hard and 4 easy
    @Published var opponentScore: Int = 0
    @Published var playerScore: Int = 0
    @Published var winPoints: Int = 0
    @Published var selectedCubes: [CubeModel] = []
    @Published var selectedCubesOpponent: [CubeModel] = []
    @Published var cubes: [CubeModel] = []
    
    @Published
    private(set) var opened: Set<CubeModel.ID> = []
    
    @Published
    private(set) var disabled: Set<CubeModel.ID> = []
    @Published var touchesDisabled: Bool = false
    @Published var blockAllField: Bool = false
    
    let playerName: String = "Pavel"
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
    
    private func checkSelection() {
        guard selectedCubes.count == 2 else {
            return
        }
        stepsCount += 1 // step count for move your opponent
        touchesDisabled = true // disabled whole screen for touch
        
        if matchingCubes(cubes: selectedCubes) {
            playerScore += 1
            selectedCubes.forEach { cube in
                    disabled.insert(cube.id)
                }
            selectedCubes.removeAll()
            
            Task {
                try await performDelay {
                    self.actionMoveOpponent()
                }
            }
            
        } else {
            Task {
                try await performDelay {
                    self.selectedCubes.forEach { cube in
                        self.opened.remove(cube.id)
                    }
                    self.selectedCubes.removeAll()
                }
            }
            
            
            Task {
                try await performDelay {
                    self.actionMoveOpponent()
                }
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
    
    // add delay to keep cubes opened
    private func performWithDelay(sleepTime: Int = 1, @_implicitSelfCapture _ callback: @escaping () -> Void) {
        Task {
            do {
                try await Task.sleep(for: .seconds(sleepTime))
                callback()
            } catch {
                print("Failed to sleep \(error)")
            }
        }
    }
    
    // MARK: AI LOGIC WORK
    
    // turn AI found match cubes with 100%
    func perfectMatchCubesAI() {
        let filteredCubes = cubes.filter { !disabled.contains($0.id) }
        guard let openRandomCube = filteredCubes.randomElement(),
                !disabled.contains(openRandomCube.id),
                !opened.contains(openRandomCube.id),
              disabled.count >= (disabled.count - 2) else {
            return
        }
        
        let foundedPair = cubes.filter { $0.imageName == openRandomCube.imageName }
        
        Task {
             try await foundedMatchCubes(for: foundedPair)
        }
    }
    
    func foundedMatchCubes(for cubes: [CubeModel]) async throws {
        try await performDelay {
            for cube in cubes {
                self.opened.insert(cube.id)
                self.disabled.insert(cube.id)
            }
            self.opponentScore += 1
        }
        try Task.checkCancellation()
        touchesDisabled = false
    }
    
    
    // MARK: - open random pair of cube and compare them
    func openRandomCubesAI() {
        let filteredCubes = cubes.filter { !disabled.contains($0.id) }
        guard let openRandomCube = filteredCubes.randomElement(),
                let openRandomCube2 = filteredCubes.randomElement(),
                !disabled.contains(openRandomCube.id),
                !opened.contains(openRandomCube.id),
                !disabled.contains(openRandomCube2.id),
                !opened.contains(openRandomCube2.id),
              disabled.count >= (disabled.count - 2) else {
            return
        }
        
        let foundedPair = [openRandomCube, openRandomCube2]
        
        if matchingCubes(cubes: foundedPair) {
            Task {
                 try await foundedMatchCubes(for: foundedPair)
            }
            
        } else {
            Task {
                try await delayOpenedAndClose(for: foundedPair)
               
              //  touchesDisabled = false

            }
            
        }
    }
    
    private func performDelay(timeSleep: Int = 1 ,_ callback: @escaping () -> Void) async throws {
        try await Task.sleep(for: .seconds(timeSleep))
        callback()
    }
    
    func delayOpenedAndClose(for cubes: [CubeModel]) async throws {
        try await performDelay {
            for cube in cubes {
                self.opened.insert(cube.id)
            }
        }
        
        try await performDelay {
            for cube in cubes {
                self.opened.remove(cube.id)
            }
        }
        try Task.checkCancellation()
        touchesDisabled = false
        
    }
    
    func matchingCubes(cubes: [CubeModel]) -> Bool {
        return cubes[0].imageName == cubes[1].imageName
    }
        
    // MARK: - combine working on AI move
    private func actionMoveOpponent() {
        if stepsCount % 3 == 0 {
            perfectMatchCubesAI()
        } else {
            openRandomCubesAI()
        }
       

    }
}


