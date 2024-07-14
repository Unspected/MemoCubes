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
}

final class GameViewModel: ObservableObject, CubesServiceProtocol {
   
    private let cubeImages: [String] = ["magic-carpet", "swords", "camel",
                                        "camel-shape", "cactus", "castle",
                                        "genie_lamp", "oil_fabric", "papyrus",
                                        "scorpion", "magic_lamp", "sarcophagus",
                                        "scarab_bug", "snake"]
    
    @Published var playerScore: Int = 0
    @Published var winPoints: Int = 0
    @Published var selectedCubes: [CubeModel] = [] // selected Step
    @Published var cubes: [CubeModel] = []
    
    @Published
    private(set) var opened: Set<CubeModel.ID> = []
    
    @Published
    private(set) var disabled: Set<CubeModel.ID> = []
    
    private var touchesDisabled: Bool = false
    
    init() {
        shuffleGame()
    }
    
    func onTapCube(cube: CubeModel) {
        guard
            !touchesDisabled,
            !disabled.contains(cube.id)
        else {
            return
        }
        opened.insert(cube.id)
        selectedCubes.append(cube)
        checkSelection()
    }
    
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
        
        if selectedCubes[0].imageName == selectedCubes[1].imageName {
            playerScore += 1
            selectedCubes.forEach { cube in
                disabled.insert(cube.id)
            }
            selectedCubes.removeAll()
            performWithDelay {
                checkIfWon()
            }
        } else {
            touchesDisabled = true
            performWithDelay {
                selectedCubes.forEach { cube in
                    opened.remove(cube.id)
                }
                selectedCubes.removeAll()
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
    
    private func performWithDelay(@_implicitSelfCapture _ callback: @escaping () -> Void) {
        touchesDisabled = true
        Task {
            try await Task.sleep(nanoseconds: NSEC_PER_SEC * 1)
            callback()
            touchesDisabled = false
        }
    }
}

