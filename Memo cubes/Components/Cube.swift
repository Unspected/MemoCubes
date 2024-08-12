import SwiftUI

struct Cube: View {
    private let screenHeight = UIScreen.main.bounds.size.height
    
    struct ViewState {
        let imageName: String
        let isOpened: Bool
    }
    
    let viewState: ViewState
    
    var body: some View {
        RoundedRectangle(cornerRadius: 11.0)
            .fill(.naturalWood)
            .overlay {
                Image(viewState.imageName)
                    .resizable()
                    .scaledToFit()
                    .padding(10)
                    .opacity(viewState.isOpened ? 1 : 0)
                    .rotation3DEffect(Angle.degrees(viewState.isOpened ? 180 : 360), axis: (0,1,0))
            }
            .frame(minWidth: 80, maxWidth: .infinity)
            .frame(minHeight: screenHeight / 9, maxHeight: .infinity)
            .rotation3DEffect(Angle.degrees(viewState.isOpened ? 180 : 360), axis: (0,1,0))
            .animation(.easeInOut, value: viewState.isOpened)
    }
}

