//
//  AboutSheet.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-11.
//

import SwiftUI

struct AboutSheet: View {
  private let currentYear: String
  
  init() {
    let today = Date.now
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year], from: today)
    currentYear = String(components.year ?? 2022)
  }
  
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
        Text(" \(currentYear)")
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
