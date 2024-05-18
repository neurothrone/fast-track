import SwiftUI

struct GradientButtonView: View {
  let label: String
  let action: () -> Void
  
  var body: some View {
    Button(action: action) {
      Text(label)
        .foregroundColor(.primary)
    }
    .padding()
    .contentShape(RoundedRectangle(cornerRadius: 20))
    .background(
      RoundedRectangle(cornerRadius: 20)
        .fill(.ultraThinMaterial)
    )
    .background(
      LinearGradient(
        colors: [.purple, .purple.opacity(0.5)],
        startPoint: .leading,
        endPoint: .trailing
      )
      .cornerRadius(20)
    )
    .background(
      RoundedRectangle(cornerRadius: 20)
        .stroke(.purple.gradient, lineWidth: 1)
    )
    .shadow(color: .purple, radius: 2)
    .shadow(color: .purple.opacity(0.75), radius: 2)
    .shadow(color: .purple.opacity(0.5), radius: 2)
  }
}

struct GradientButtonView_Previews: PreviewProvider {
  static var previews: some View {
    GradientButtonView(label: "Start", action: {})
      .preferredColorScheme(.dark)
  }
}
