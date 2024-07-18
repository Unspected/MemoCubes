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
            topBar(playerName: "Pavel \(viewModel.playerScore)", oppositeName: "Opponent \(viewModel.opponentScore)")
            LazyVGrid(columns: columns, spacing: 5) {
                ForEach(viewModel.cubes) { cube in
                    Cube(
                        viewState: .init(
                            imageName: cube.imageName,
                            isOpened: viewModel.opened.contains(cube.id),
                            isDisabled: viewModel.touchesDisabled
                        )
                    )
                  //  .disabled(viewModel.touchesDisabled)
                    .opacity(viewModel.disabled.contains(cube.id) ? 0.7 : 1)
                    .onTapGesture {
                        withAnimation(.linear(duration: 0.5)) {
                            if !viewModel.opened.contains(cube.id) {
                                viewModel.onTapCube(cube: cube)
                            }
                        }
                    }
                }
            }
            .padding(10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("game_background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)
        )
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
