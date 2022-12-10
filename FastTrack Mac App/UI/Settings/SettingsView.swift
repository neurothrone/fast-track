//
//  SettingsView.swift
//  FastTrack Mac App
//
//  Created by Zaid Neurothrone on 2022-12-07.
//

import SwiftUI

struct SettingsView: View {
  var body: some View {
    TabView {
      Form {
      }
      .padding()
      .frame(width: 400)
      .tabItem {
        Label("Preferences", systemImage: "number.circle")
      }
      
      Form {
        
      }
      .padding()
      .tabItem {
        Label("Advanced", systemImage: "gearshape.2")
      }
    }
    .frame(width: 400)
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
  }
}
