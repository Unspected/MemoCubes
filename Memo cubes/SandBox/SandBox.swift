import SwiftUI
import Combine

struct Model: Identifiable, Equatable {
    let id = UUID()
    let name: String
    var isShow: Bool
    var isDisabled: Bool
}

struct WrapperModel: View {
    
    @Binding var model: Model
    
    var body: some View {
        VStack {
            if model.isShow {
                Text("model is Showed")
                Text(model.name)
            } else {
                Text("model is Hide")
                Text(model.name)
            }
        }
        .onTapGesture {
            model.isShow.toggle()
        }
    }
}


class SandBoxViewModel: ObservableObject {
    
    @Published var models: [Model] = [
        .init(name: "sword", isShow: false, isDisabled: false),
        .init(name: "sword1", isShow: false, isDisabled: false),
        .init(name: "sword2", isShow: false, isDisabled: false)
    ]
}

struct SandBox: View {
    
    @StateObject var vm: SandBoxViewModel = SandBoxViewModel()
    
    var body: some View {
        VStack {
            ForEach($vm.models) { $model in
                WrapperModel(model: $model)
            }
        }
    }
}

#Preview {
    SandBox()
}
