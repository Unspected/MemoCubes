
import SwiftUI

struct MainMenu: View {
    
    @State var isShowView: Bool = false
    
    var body: some View {
        VStack {
            Text("Welcome to Memo Cubes")
                .foregroundStyle(Color.white)
                .font(.headline)
            
            startPlayButton()
                .padding(.top, 35)
            Spacer()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("desert")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)
                )
        .fullScreenCover(isPresented: $isShowView, content: {
            GameView()
        })
    }
    
    @ViewBuilder
    private func startPlayButton() -> some View {
        Text("Play vs AI")
            .foregroundStyle(Color.white)
            .frame(minWidth: 200, minHeight: 40)
            .background(RoundedRectangle(cornerRadius: 4).fill(Color.white.opacity(0.5)).stroke(Color.white))
            .onTapGesture {
                isShowView.toggle()
            }
    }
}

#Preview {
    MainMenu()
}
