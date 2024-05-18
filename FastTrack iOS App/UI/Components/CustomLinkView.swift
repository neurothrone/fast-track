import SwiftUI

struct CustomLinkView: View {
  let urlString: String
  let text: String
  
  var body: some View {
    Link(destination: URL(string: urlString)!) {
      HStack(alignment: .center) {
        Text(text)
          .font(.footnote)
        Image(systemName: "link.circle.fill")
      }
    }
  }
}

struct CustomLinkView_Previews: PreviewProvider {
  static var previews: some View {
    CustomLinkView(
      urlString: MyApp.Link.svgRepo,
      text: "App icon by svgrepo.com"
    )
  }
}
