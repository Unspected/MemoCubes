import Foundation
import SwiftUI

struct ScaleOnChangeModifier: ViewModifier {
    @Binding var value: Int
    @State private var scale: CGFloat = 1.0

    func body(content: Content) -> some View {
        content
            .scaleEffect(scale)
            .onChange(of: value) { newValue, _ in
                withAnimation(.easeInOut(duration: 0.2)) {
                    scale = 2
                }
                withAnimation(.easeInOut(duration: 0.2).delay(0.2)) {
                    scale = 1.0
                }
            }
    }
}

extension View {
    func scaleOnChange(value: Binding<Int>) -> some View {
        self.modifier(ScaleOnChangeModifier(value: value))
    }
}

