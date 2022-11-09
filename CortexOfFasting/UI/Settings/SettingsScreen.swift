//
//  SettingsScreen.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-08.
//

import SwiftUI

struct SettingsScreen: View {
  var body: some View {
    NavigationStack {
      content
        .linearBackground()
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
  }
  
  private var content: some View {
    VStack {
      Text("Settings")
    }
  }
}

struct SettingsScreen_Previews: PreviewProvider {
  static var previews: some View {
    SettingsScreen()
  }
}
