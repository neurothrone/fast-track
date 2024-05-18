import SwiftUI

struct SectionHeaderView: View {
  let leftText: String
  var rightText: String? = nil
  
  var body: some View {
    HStack {
      Text(leftText)
      
      Spacer()
      
      if let rightText {
        Text(rightText)
      }
    }
    .font(.headline)
    .foregroundColor(.secondary)
    .textCase(.none)
  }
}

struct SectionHeaderView_Previews: PreviewProvider {
  static var previews: some View {
    SectionHeaderView(leftText: "Fasting times", rightText: "Fasting duration")
  }
}
