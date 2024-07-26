import SwiftUI

struct MovePointer: View {
    
    @Binding var switchMove: Bool {
        didSet {
            print(self)
        }
    }
  
    var body: some View {
        HStack {
            Text(switchMove ? "PC is moving" : "Your turn")
                .font(.arabic(.alladinFont, 20))
                .foregroundStyle(Color.white)
                .scaleEffect(switchMove ? 1 : 1.5)
                .animation(.easeOut(duration: 0.7), value: switchMove)
        }
    }
    
  
    
}

#Preview {
    MovePointer(switchMove: .constant(true)).background(Color.black)
}
