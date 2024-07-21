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
            exitButton()
            scoreBoard()
            ZStack {
                LazyVGrid(columns: columns, spacing: 5) {
                    ForEach(viewModel.cubes) { cube in
                        Cube(
                            viewState: .init(
                                imageName: cube.imageName,
                                isOpened: viewModel.opened.contains(cube.id)
                            )
                        )
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
                if viewModel.touchesDisabled {
                    Color.black.opacity(0.5)
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture {
                            }
                            .transition(.opacity)
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
    private func scoreBoard() -> some View {
        HStack {
            Text("\(viewModel.playerName)")
                .fontWeight(.light)
            Text("\(viewModel.playerScore)")
                .scaleOnChange(value: $viewModel.playerScore)
                Spacer()
            Text("\(viewModel.opponentScore)")
                .scaleOnChange(value: $viewModel.opponentScore)
            Text(viewModel.opponentName)
                .fontWeight(.light)
               
        }
        .font(.headline)
        .foregroundStyle(Color.white)
        .padding(.trailing, 10)
        .padding(.leading, 10)
    }
    
    @ViewBuilder
    private func exitButton() -> some View {
        Button(action: {
            showingAlert = true
        }, label: {
            Text("Exit")
                .font(.arabic(.alladinFont, 30))
                .foregroundStyle(.white)
        })
        
        .alert("Do you want to leave the game ?", isPresented: $showingAlert) {
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
