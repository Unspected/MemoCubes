import SwiftUI

struct PageCardView: View {

    var page: OnboardingDataModel
    let buttonTitle: String
    @State private var isAnimating: Bool = false
    var actionButton: () -> (Void)
    
    var body: some View {
      ZStack {
          VStack(alignment: .center,spacing: 0) {
          Image(page.image)
            .resizable()
            .scaledToFit()
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 8, x: 6, y: 8)
            .scaleEffect(isAnimating ? 1.0 : 0.6)
            .padding(30)
        Spacer()
          Text(page.title)
            .foregroundColor(Color.white)
            .font(.largeTitle)
            .fontWeight(.heavy)
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2, x: 2, y: 2)
          
          Text(page.headline)
            .foregroundColor(Color.white)
            .multilineTextAlignment(.center)
            .padding(15)
            .frame(maxWidth: 480)
          Spacer()
              nextButton
                  .padding(.bottom, 25)
          
        }
      }
      .onAppear {
        withAnimation(.easeOut(duration: 0.5)) {
          isAnimating = true
        }
      }
      .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
      .background(LinearGradient(gradient: Gradient(colors: page.gradientColors), startPoint: .top, endPoint: .bottom))
      .cornerRadius(20)
      .padding(.horizontal, 20)

    }
    
    @ViewBuilder
    var nextButton: some View {
        Button(action: {
                actionButton()
            }) {
              HStack(spacing: 8) {
                Text(buttonTitle)

                Image(systemName: "arrow.right.circle")
                  .imageScale(.large)
              }
              .padding(.horizontal, 16)
              .padding(.vertical, 10)
              .background(
                Capsule().strokeBorder(Color.white, lineWidth: 1.25)
              )
            } //: BUTTON
            .accentColor(Color.white)
    }
}

#Preview {
    PageCardView(
        page:
            OnboardingDataModel(
                title: "About",
                headline: "We’re excited to have you here and introduce you to our fun and engaging game designed to boost your visual memory skills. Memo Cubes is perfect for both children and adults, offering a playful way to enhance your memory while having a great time.",
                image: "VisualMemory",
                gradientColors: [Color.blue, Color.blue.opacity(0.5)]),
        buttonTitle: "",
        actionButton: { }
    )
}


