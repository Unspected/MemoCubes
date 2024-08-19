//
//  OnBoardingButton.swift
//  Memo cubes
//
//  Created by Pavel Andreev on 8/18/24.
//

import SwiftUI

struct OnBoardingButton: View {
    // MARK: - PROPERTIES
    
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    
    // MARK: - BODY
    
    var body: some View {
      Button(action: {
        isOnboarding = false
      }) {
        HStack(spacing: 8) {
          Text("Start")
          
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
    OnBoardingButton()
        .preferredColorScheme(.dark)
        .previewLayout(.sizeThatFits)
}
