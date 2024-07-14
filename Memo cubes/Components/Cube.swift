import SwiftUI

struct Cube: View {
    
    @Binding var model: CubeModel
    
    var body: some View {
        VStack {
            ZStack {
                if model.isDisabled {
                    RoundedRectangle(cornerRadius: 10.0)
                        .fill(.naturalWood)
                        .transition(.reverseFlip)
                        .overlay {
                            Image(model.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                    }
                }
                else {
                    if model.isShow {
                        RoundedRectangle(cornerRadius: 10.0)
                            .fill(.naturalWood)
                            .transition(.reverseFlip)
                            .overlay {
                                Image(model.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                            }
                    } else {
                        RoundedRectangle(cornerRadius: 10.0)
                            .fill(.naturalWood)
                            .transition(.flip)
                    }
                }
            }
            .frame(width: 70, height: 70)
        }
    }
}

#Preview {
    Cube(model: .constant(CubeModel(imageName: "swords")))
    
}


struct FlipTransition: ViewModifier {
    var progress: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .rotation3DEffect(
                .init(degrees: progress * 180),
                    axis: (x: 0.0, y: 1.0, z: 0.0)
            )
    }
}

extension AnyTransition {
    static let flip: AnyTransition = .modifier(
        active: FlipTransition(progress: 1),
        identity: FlipTransition())
    
    static let reverseFlip: AnyTransition = .modifier(
        active: FlipTransition(progress: -1),
        identity: FlipTransition())
}
