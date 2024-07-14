import Foundation
import Combine

struct CubeModel: Identifiable, Equatable {
    let id: UUID = UUID()
    let imageName: String
    var isShow: Bool = false
    var isDisabled: Bool = false
    
    // Conform to Equatable to compare models based on properties
    static func == (lhs: CubeModel, rhs: CubeModel) -> Bool {
        return lhs.imageName == rhs.imageName
    }
}

protocol CubesServiceProtocol {
    func fetchCubes()
    func checkSelectedCubes() -> Bool
    
}

final class GameViewModel: ObservableObject, CubesServiceProtocol {
   
    private let cubeImages: [String] = ["magic-carpet", "swords", "camel", "camel-shape"]
    private var cancellable = Set<AnyCancellable>()
    
    @Published var winPoints: Int = 0
    @Published var stepCount: Int = 0
    @Published var selectedCubes: [CubeModel] = [] // selected Step
    @Published var cubes: [CubeModel] = []
    
    var cubesIsMatched: PassthroughSubject<Bool, Never> = PassthroughSubject()
    
    init() {
      checkSelectedCubesSubscription()
      cubesMatchingSubscription()
      observersSelectedValue()
    }
    
    func observersSelectedValue() {
        $selectedCubes
            .map { $0 }
            .sink(receiveValue:  { [weak self] value in
            print(value)
        }).store(in: &cancellable)
    }
    
    // MARK: - обработка результата
    func cubesMatchingSubscription() {
        cubesIsMatched
            .sink(
                receiveValue: { [weak self] result in
                    guard let self else { return }
                    
                        // Если картинки на кубиках совпадают ( Я оставляю эти кубики открытыми и делаю Disabled что бы нельзя больше с ними ничего ничего делать
                    
                    if result {
                        print("right answer")
                        self.matchedCubesDisabled()
                        self.selectedCubes.removeAll()

                    } else {
                        print("not match")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.hideAllOpenedCubes()
                            self.selectedCubes.removeAll()
                        }
                        
                    }
                })
            .store(in: &cancellable)
    }
    
    // MARK: - Когда мы открываем 2 кубика мы сравниваем картинки этих кубиков
    func checkSelectedCubesSubscription() {
        $stepCount
            .map { $0 }
            .sink(receiveValue: { [weak self] step in
                guard let self else { return }
                if step % 2 == 0 && step > 1 {
                    let resultMatching = checkSelectedCubes() // Результат передаем сюда true or false
                    self.cubesIsMatched.send(resultMatching)
                }
            })
            .store(in: &cancellable)
    }

    // MARK: - update fill out cubes
    func fetchCubes() {
        let copyArray = cubeImages.flatMap { [ $0, $0] }.shuffled()
        
        for item in copyArray {
            let element = CubeModel(imageName: item, isShow: false, isDisabled: false)
            cubes.append(element)
        }
    }
    
    // MARK: check match cubes
    func checkSelectedCubes() -> Bool {
        return selectedCubes[0].imageName == selectedCubes[1].imageName
    }
    
    func resetSelectedCubes() {
        self.selectedCubes = []
        print("RESET SELECTED VALUES is \(selectedCubes.count)")
    }
    
    // Сделать Disabled cubes который совпали и оставить их открытыми
    func matchedCubesDisabled() {
        for i in 0..<selectedCubes.count {
            if cubes.contains(where: { $0.imageName == selectedCubes[i].imageName }) {
                cubes[i].isDisabled = true
                
            }
        }
        resetSelectedCubes()
    }
    
    // MARK: - Закрыть кубики которые были открыты
    func hideAllOpenedCubes() {
        for cube in selectedCubes {
            if let index = cubes.firstIndex(of: cube) {
                cubes[index].isShow = false
            }
        }
    }
    
    
    
    
    
    
    
    
    
}
