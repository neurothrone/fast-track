//
//  ContentView.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-08.
//

import SwiftUI

struct ContentView: View {
  @AppStorage(Constants.AppStorage.selectedScreen)
  private var selectedTab: Screen = .activeWeek
  
  var body: some View {
    TabView(selection: $selectedTab) {
      Group {
        ForEach(Screen.allCases) { screen in
          screen.view()
            .tabItem {
              Label(screen.rawValue, systemImage: screen.systemImage)
            }
        }
      }
      .toolbarBackground(.visible, for: .tabBar)
      .toolbarBackground(.ultraThinMaterial, for: .tabBar)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
      .preferredColorScheme(.dark)
  }
}
