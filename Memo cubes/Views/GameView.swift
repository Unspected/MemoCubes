import SwiftUI

struct GameView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var showingAlert: Bool = false
    @StateObject var viewModel: GameViewModel = GameViewModel()
    private let impactTap = UIImpactFeedbackGenerator(style: .medium)
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                exitButton()
            }
            scoreBoard()
            Spacer()
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
                            
                            impactTap.impactOccurred() // Vibration
                            
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
        ZStack {
            HStack {
                Text("\(viewModel.playerName)")
                    .font(.arabic(.alladinFont, 25))
                    .fontWeight(.medium)
                Text("\(viewModel.playerScore)")
                    .scaleOnChange(value: $viewModel.playerScore)
                    .font(.title)
                Spacer()
                MovePointer(switchMove: $viewModel.touchesDisabled)
                Spacer()
                Text("\(viewModel.opponentScore)")
                    .scaleOnChange(value: $viewModel.opponentScore)
                    .font(.title)
                Text(viewModel.opponentName)
                    .font(.arabic(.alladinFont, 25))
                    .fontWeight(.medium)
            }
            
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
                .font(.arabic(.alladinFont, 25))
                .foregroundStyle(.white)
        })
        .padding(.trailing, 20)
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
