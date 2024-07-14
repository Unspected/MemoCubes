import SwiftUI

struct Cube: View {
    
    struct ViewState {
        let imageName: String
        let isOpened: Bool
    }
    
    let viewState: ViewState
    
    var body: some View {
        Color.naturalWood
            .overlay {
                Image(viewState.imageName)
                    .resizable()
                    .scaledToFill()
                    .padding(10)
                    .opacity(viewState.isOpened ? 1 : 0)
                    .rotation3DEffect(Angle.degrees(viewState.isOpened ? 180 : 360), axis: (0,1,0))
            }
            .aspectRatio(1, contentMode: .fit)
            .clipShape(.rect(cornerRadius: 10))
            .animation(.easeInOut, value: viewState.isOpened)
    }
}

#if DEBUG

struct Cube_Preview: View {
    
    @State
    private var isOpened: Bool = false
    
    var body: some View {
        Cube(
            viewState: .init(
                imageName: "swords",
                isOpened: isOpened
            )
        )
        .frame(width: 70, height: 70)
        .onTapGesture {
            isOpened.toggle()
        }
    }
}

#endif

#Preview {
    VStack {
        Cube_Preview()
    }
}
