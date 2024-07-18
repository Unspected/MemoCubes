
import SwiftUI

struct MainMenu: View {
    
    @State var isShowView: Bool = false
    @State var isAppear = false
    @State var titleText = "Welcome"
    
    var body: some View {
        VStack {
            Text(titleText)
                .foregroundStyle(Color.white)
                .font(.arabic(.ramadhankarimFont, 65))
            startPlayButton()
                .padding(.top, 10)
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
            .font(.arabic(.alladinFont, 35))
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
