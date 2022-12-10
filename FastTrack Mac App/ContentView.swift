//
//  ContentView.swift
//  FastTrack Mac App
//
//  Created by Zaid Neurothrone on 2022-12-07.
//

import SwiftUI

struct ContentView: View {
  @State private var selection: Screen?
  
  var body: some View {
    NavigationSplitView {
      List(selection: $selection) {
        Section {
          ForEach(Screen.allCases.filter { $0 != .settings }) { screen in
            Label(screen.rawValue, systemImage: screen.systemImage)
          }
        } header: {
          Text("Views")
        }
      }
      .frame(width: 150)
    } detail: {
      if let selection {
        selection.screen
      } else {
        Text("Please select something")
      }
    }
    .frame(minWidth: 480, minHeight: 320)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
