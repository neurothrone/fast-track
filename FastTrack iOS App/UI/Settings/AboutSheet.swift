//
//  AboutSheet.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-11.
//

import SwiftUI

struct AboutSheet: View {
  var body: some View {
    NavigationStack {
      content
        .padding()
        .background(
          .thinMaterial
        )
        .cornerRadius(20)
        .linearBackground()
    }
    .navigationTitle("About")
    .navigationBarTitleDisplayMode(.inline)
  }
  
  private var content: some View {
    VStack(spacing: 4) {
      HStack(spacing: 0) {
        Text("Made with ")
        Image(systemName: "heart.fill")
          .foregroundColor(.purple)
        Text(" by Zane Neurothrone")
        
      }
      
      HStack(spacing: 0) {
        Text("Copyright ")
        Image(systemName: "c.circle")
        Text(" ")
        Text(Date.now, format: .dateTime.year())
      }
      
      Text("Version \(UIApplication.appVersion)")
        .foregroundColor(.purple)
      
      CustomLinkView(urlString: MyApp.Link.svgRepo, text: "App icon by svgrepo.com")
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
