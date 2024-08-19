import SwiftUI

struct TwoPlayersGameView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var showingAlert: Bool = false
    @StateObject var viewModel: GameViewModel2 = GameViewModel2()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    TwoPlayersGameView()
}
