import SwiftUI

struct GameView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var showingAlert: Bool = false
    @StateObject var viewModel: GameViewModel = GameViewModel()
    
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            Text("\(viewModel.winPoints)")
                .foregroundStyle(.white)
                .font(.title)
            topBar(playerName: "Pavel", oppositeName: "Ai")
            LazyVGrid(columns: columns, spacing: 5) {
                ForEach($viewModel.cubes) { $cube in
                    Cube(model: $cube,
                         stepCount: $viewModel.stepCount,
                         selectedCubes: $viewModel.selectedCubes)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("game_background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)
        )
        .task(priority: .high) {
            viewModel.fetchCubes()
            
        }
//        .onReceive(viewModel.$stepCount, perform: { step in
//            print("выбрано купибиков \(viewModel.selectedCubes.count)")
//            if step == 2 {
//                viewModel.resetSteps()
//                viewModel.checkSelectedCubes() ? print("true") : viewModel.hideAllOpenedCubes()
//            }
//        })
    }
    
    @ViewBuilder
    private func topBar(playerName: String, oppositeName: String) -> some View {
        HStack {
            Text(playerName)
                .padding(.leading, 10)
                .foregroundStyle(Color.white)
                Spacer()
            Text(oppositeName)
                .foregroundStyle(Color.white)
                .padding(.trailing, 10)
        }
        .padding()
        .border(Color.white)
    }
    
    @ViewBuilder
    private func exitButton() -> some View {
        Button(action: {
            showingAlert = true
        }, label: {
            Image(systemName: "xmark")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundStyle(Color.red)
        })
        
        .alert("Important message", isPresented: $showingAlert) {
            Button("Yes") {
                dismiss()
            }
            Button("No") {
                
            }
        }
    }
}

#Preview {
    GameView()
}
