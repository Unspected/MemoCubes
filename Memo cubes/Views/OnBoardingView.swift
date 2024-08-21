import SwiftUI

struct OnBoardingView: View {
    
    @State var pages: [OnboardingDataModel]
    @State var pageIndex: Int = 0
    @AppStorage("isOnboarding") var isOnboarding: Bool?

    var body: some View {
          ZStack {
                  PageCardView(
                    page: pages[pageIndex],
                    buttonTitle: pageIndex == pages.count ? "Finish" : "Next",
                    actionButton: nextPageAction)
                  .animation(.easeIn, value: pageIndex)
            }
          .background(
            Image("background_onboarding")
          )
    }
    
    private func nextPageAction() {
        print("pushed")
        if pageIndex < (pages.count - 1) {
            pageIndex += 1
        } else {
            self.isOnboarding = false
        }
    }
    
    private func progressView() -> some View {
        HStack {
            ForEach(0..<pages.count, id: \.self) { i in
                    Circle()
                        .scaledToFit()
                        .frame(width: 10)
                        .foregroundColor(self.pageIndex >= i ? Color(.systemIndigo) : Color(.systemGray))
                }
            }
        }
    
}


#Preview {
    OnBoardingView(pages: OnboardingDataModel.models)
}
