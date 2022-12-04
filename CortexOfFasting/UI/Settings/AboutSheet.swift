//
//  AboutSheet.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-11.
//

import SwiftUI

struct AboutSheet: View {
  private let today: Date = .now

  var body: some View {
    VStack(spacing: 4) {
      HStack(spacing: 0) {
        Text("Made with ")
        Image(systemName: "heart.fill")
          .foregroundColor(.purple)
        Text(" by Zaid Neurothrone")
        
      }
      
      HStack(spacing: 0) {
        Text("Copyright ")
        Image(systemName: "c.circle")
        Text(" \(today.year)")
      }
      
      Text("Version \(UIApplication.appVersion)")
        .foregroundColor(.secondary)
      
      CustomLinkView(urlString: Constants.Link.svgRepo, text: "App icon by svgrepo.com")
        .padding(.top)
    }
  }
}

struct AboutSheet_Previews: PreviewProvider {
  static var previews: some View {
    AboutSheet()
      .preferredColorScheme(.dark)
  }
}
