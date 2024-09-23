import SwiftUI

struct SetupUserView: View {
    
    @ObservedObject var vm: MainMenuViewModel
    @Environment(\.dismiss) var dismiss
    @State var text: String = ""
    @State var isValidUserName: Bool = false
    @State var showError: Bool = false
    @State var showSuccessCreatedUser: Bool = false
    
    var body: some View {
        VStack() {
            Text("For start playing game, nessesary create username")
                .font(.arabic(.alladinFont, 35))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding()
                
            TextField("Enter Username", text: $vm.user.name)
                .foregroundStyle(.white)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(
                            vm.user.name.count >= 3 ? .blueGray : .red.opacity(0.8),
                            lineWidth: 2)
                )
                .padding()
            if showError {
                Text("Entered user name is too short")
                    .foregroundStyle(Color.red.opacity(0.8))
                    .font(.caption)
                    .frame(maxWidth: .infinity)
            }
            
            Button(action: {
                actionButton()
                
            }, label: {
                Text("Create new User")
                    .font(.arabic(.alladinFont, 20))
                    .padding(2)
                    
            })
            .buttonStyle(.borderedProminent)
            .tint(vm.user.name.count >= 3 ? .blueGray : .red.opacity(0.8))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("dessertDark")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)
        )
        .onDisappear(perform: {
            showError = false
        })
        .onChange(of: text) {
            hideErrorMessage()
        }
        .popover(isPresented: $showSuccessCreatedUser) {
            CustomAlertView(title: "Success Registration",
                            message: "Username successfully created and saved in phone memory",
                            primaryButtonLabel: "OK, Go to play",
                            primaryButtonAction: { dismiss() }
            )
            .padding(10)
            .presentationBackground(.clear)
        }
    }
    
    private func hideErrorMessage() {
        if vm.user.name.count >= 3 {
            showError = false
        }
    }
    
    private func actionButton() {
        guard vm.user.name.count > 2 else {
            showError = true
            return
        }
        vm.saveData()
        showSuccessCreatedUser = true
        
    }
}

#Preview {
    SetupUserView(vm: MainMenuViewModel(context: DI.dataService))
        
}
