import SwiftUI

struct OnboardingDataModel: Identifiable {
  var id = UUID()
  var title: String
  var headline: String
  var image: String
  var gradientColors: [Color]
}

extension OnboardingDataModel {
    
    static var models: [OnboardingDataModel] = [
        OnboardingDataModel(
            title: "The game rules",
            headline: """
            1. Open Two Cubes: \n Tap on two cubes to reveal their images. \n
            2. Match and Score: \n If the images on the cubes match, you earn a point \n
            3. No Match: \n If the images do not match, the turn passes to your opponent.
            Keep track of the opened cubes and remember the images you need to match to earn points.
            """,
            image: "",
            gradientColors: [Color.blue, Color.blue.opacity(0.5)]),
        OnboardingDataModel(
            title: "About Game",
            headline: "We’re excited to have you here and introduce you to our fun and engaging game designed to boost your brain and visual memory skills. Memo Cubes is perfect for both children and adults, offering a playful way to enhance your memory while having a great time.",
            image: "VisualMemory",
            gradientColors: [Color.blue, Color.blue.opacity(0.5)]),
        
        OnboardingDataModel(
            title: "Single Player",
            headline: "Dive into a solo challenge where you can test and improve your visual memory skills at your own pace. This mode offers various levels of difficulty to keep you engaged and challenged.",
            image: "",
            gradientColors: [Color.blue])
    ]
}
