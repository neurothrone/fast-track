import SwiftUI

extension View {
  func linearBackground(colorScheme: ColorScheme = .dark) -> some View {
    ZStack {
      LinearGradient(
        colors: [
          .mint.opacity(colorScheme == .dark ? 0.2 : 0.5),
          .purple.opacity(0.5),
          .mint.opacity(0.25)
        ],
        startPoint: .top,
        endPoint: .bottom
      )
      .edgesIgnoringSafeArea(.all)
      
      self
    }
  }
}
