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

enum TurnMakeMove {
    case player
    case opponent
}

@MainActor
protocol CubesServiceProtocol {
    func onTapCube(cube: CubeModel)
}

final class GameViewModel: ObservableObject, CubesServiceProtocol {
   
    private let cubeImages: [String] = ["magic-carpet", "swords", "camel",
                                        "camel-shape", "cactus", "castle",
                                        "genie_lamp", "oil_fabric", "papyrus",
                                        "scorpion", "magic_lamp", "sarcophagus",
                                        "scarab_bug", "snake"]
    // TODO
    // @Published var gameDifficulty: Int = 0 where is 0 it's hard and 4 easy
    @Published var opponentScore: Int = 0
//    @Published var selectedOpponentCubes: [CubeModel] = []
    @Published var playerScore: Int = 0
    @Published var winPoints: Int = 0
    @Published var selectedCubes: [CubeModel] = []
    @Published var selectedCubesOpponent: [CubeModel] = []
    @Published var cubes: [CubeModel] = []
    
    @Published
    private(set) var opened: Set<CubeModel.ID> = []
    
    @Published
    private(set) var disabled: Set<CubeModel.ID> = []

    private var opponentStepCount: Int = 0
    @Published var touchesDisabled: Bool = false
    
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
        opponentStepCount += 1
        if matchingCubes(cubes: selectedCubes) {
            playerScore += 1
            selectedCubes.forEach { cube in
                    disabled.insert(cube.id)
                }
            selectedCubes.removeAll()
            
            performWithDelay {
                actionMoveOpponent()
            }
            
//            performWithDelay {
//                checkIfWon()
//            }
        } else {
            touchesDisabled = true
            performWithDelay {
                selectedCubes.forEach { cube in
                    opened.remove(cube.id)
                }
                selectedCubes.removeAll()
            }
            actionMoveOpponent()
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
    private func performWithDelay(seconds: UInt64 = 1, @_implicitSelfCapture _ callback: @escaping () -> Void) {
        touchesDisabled = true
        Task {
            try await Task.sleep(nanoseconds: NSEC_PER_SEC * seconds)
            callback()
            touchesDisabled = false
        }
    }
    
    // MARK: AI LOGIC WORK
    
    // turn AI found match cubes with 100%
    private func perfectMatchCubesAI() {
        let filteredCubes = cubes.filter { !disabled.contains($0.id) }
        guard let openRandomCube = filteredCubes.randomElement(),
                !disabled.contains(openRandomCube.id),
                !opened.contains(openRandomCube.id),
              disabled.count >= (disabled.count - 2) else {
            return
        }
        
        let foundedPair = cubes.filter { $0.imageName == openRandomCube.imageName }
        
        performWithDelay {
            foundedPair.forEach { cube in
                opened.insert(cube.id)
                disabled.insert(cube.id)
            }
            opponentScore += 1
        }
    }
    
    private func generateRandomCubes()  {
        let filteredCubes = cubes.filter { !disabled.contains($0.id) }
        while selectedCubesOpponent.count != 2 {
            if let cube = filteredCubes.randomElement(), !disabled.contains(cube.id), !opened.contains(cube.id) {
                selectedCubesOpponent.append(cube)
            }
        }
        performWithDelay {
            for cube in selectedCubesOpponent {
                opened.insert(cube.id)
            }
        }
    }
    
    // MARK: - open random pair of cube and compare them
    func openRandomCubesAI() {
        generateRandomCubes()
        
        if matchingCubes(cubes: selectedCubesOpponent) {
            for cube in selectedCubesOpponent {
                    disabled.insert(cube.id)
            }
            selectedCubesOpponent.removeAll()
            opponentScore += 1
        } else {
            performWithDelay {
                for cube in selectedCubesOpponent {
                    opened.remove(cube.id)
                }
                selectedCubesOpponent.removeAll()
            }
        }
    }
    
    private func matchingCubes(cubes: [CubeModel]) -> Bool {
        return cubes[0].imageName == cubes[1].imageName
    }
        
    // MARK: - combine working on AI move
    private func actionMoveOpponent() {
        if opponentStepCount % 2 == 0 {
            perfectMatchCubesAI()
        } else {
            openRandomCubesAI()
        }
    }
}


