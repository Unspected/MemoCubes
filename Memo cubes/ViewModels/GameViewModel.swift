import Foundation
import Combine

struct CubeModel: Identifiable, Equatable {
    let id: UUID
    let imageName: String
    var isShow: Bool = false
    var isDisabled: Bool = false
    
    init(imageName: String, isShow: Bool = true, isDisabled: Bool = false) {
           self.id = UUID()
           self.imageName = imageName
           self.isShow = isShow
           self.isDisabled = isDisabled
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
  //    observersSelectedValue()
        
    }
    
    // MARK: - обработка результата
    func cubesMatchingSubscription() {
        cubesIsMatched
            .receive(on: DispatchQueue.main)
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
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                            guard let self else { return }
                            self.hideOpenedCubes(selectedCubes: &self.selectedCubes, cubes: &self.cubes)
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
    }
    
    // MARK: - Закрыть кубики которые были открыты
    func hideAllOpenedCubes() {
        print("Выбранные значения \(selectedCubes)")
        
        for cube in selectedCubes {
            if let index = cubes.firstIndex(of: cube) {
                cubes[index].isShow = false
            }
        }
    }
    
    func hideOpenedCubes(selectedCubes: inout [CubeModel], cubes: inout [CubeModel]) {
        for i in 0..<selectedCubes.count {
            for j in 0..<cubes.count {
                if selectedCubes[i].imageName == cubes[j].imageName {
                    selectedCubes[i].isShow = false
                    cubes[j].isShow = false
                }
            }
        }
    }
    
    
    
    
    
    
    
    
    
}
