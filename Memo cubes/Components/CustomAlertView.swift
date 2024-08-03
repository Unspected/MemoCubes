import Foundation
import SwiftUI

struct CustomAlertView: View {
    var title: String?
    var message: String?
    var primaryButtonLabel: String
    var primaryButtonAction: () -> Void
    var secondaryButtonLabel: String?
    var secondaryButtonAction: (() -> Void)?
    
    var body: some View {
        VStack {
            if let title = title{
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
            }
            if let message = message {
                Text(message)
                    .font(.subheadline)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                    .padding()
                    .foregroundStyle(.white)
            }
            
            HStack(spacing: 16) {
                Button(action: {
                    self.primaryButtonAction()
                }, label: {
                    Text(primaryButtonLabel)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.red)
                        .cornerRadius(12)
                })
                if let secondaryButtonLabel = secondaryButtonLabel {
                    Button(action: {
                        self.secondaryButtonAction?()
                    }, label: {
                        Text(secondaryButtonLabel)
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.gray)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(.white, lineWidth: 2)
                            )
                    })
                }
            }
        }
        .padding()
        .background(.blueGray)
        .cornerRadius(20)
        .shadow(radius: 20)
    }
}



struct CustomAlertView_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlertView(
            title: "Finish",
            message: "Message",
            primaryButtonLabel: "Main menu",
            primaryButtonAction: {},
            secondaryButtonLabel: "Play Again",
            secondaryButtonAction: {})
                .previewLayout(.sizeThatFits)
                .padding()
            
        }
    }

