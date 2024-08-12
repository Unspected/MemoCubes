import SwiftUI

struct MainMenu: View {
    
    @State var isShowView: Bool = false
    @State var isAppear = false
    
    var body: some View {
        VStack {
            Text("Welcome")
                .foregroundStyle(Color.white)
                .font(.arabic(.alladinFont, 65))
            gameButton("Single Player", GameView())
                .padding(.top, 20)
            gameButton("Two Players", GameView())
                .padding(.top, 20)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("desert")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)
        )
//        .fullScreenCover(isPresented: $isShowView, content: {
//            GameView()
//        })
    }
    
    
    @ViewBuilder
    private func gameButton(_ nameButton: String ,_ view: some View ) -> some View {
        Text(nameButton)
            .foregroundStyle(Color.white)
            .font(.arabic(.alladinFont, 35))
            .frame(minWidth: 200, minHeight: 40)
            .background(RoundedRectangle(cornerRadius: 4).fill(Color.white.opacity(0.5)).stroke(Color.white))
            .onTapGesture {
                isShowView.toggle()
            }
            .fullScreenCover(isPresented: $isShowView, content: {
                view
            })
    }
    
    
}

#Preview {
    MainMenu()
}
