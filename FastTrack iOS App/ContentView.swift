//
//  ContentView.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-08.
//

import SwiftUI

struct ContentView: View {
  @Environment(\.colorScheme) var colorScheme
  @Environment(\.horizontalSizeClass) var sizeClass
  
  @AppStorage(MyApp.AppStorage.selectedScreen)
  var selectedTab: Screen = .activeWeek
  @AppStorage(MyApp.AppStorage.columnVisibility)
  var columnVisibility: NavigationSplitViewVisibility = .doubleColumn

  @State private var selectedScreen: Screen? = .activeWeek
  
  var body: some View {
    if sizeClass == .compact {
      TabView(selection: $selectedTab) {
        Group {
          ForEach(Screen.allCases) { screen in
            screen.view(colorScheme: colorScheme)
              .tabItem {
                Label(screen.rawValue, systemImage: screen.systemImage)
              }
          }
        }
        .toolbarBackground(.visible, for: .tabBar)
        .toolbarBackground(.ultraThinMaterial, for: .tabBar)
      }
    } else {
      NavigationSplitView(columnVisibility: $columnVisibility) {
        List(Screen.allCases, selection: $selectedScreen) { screen in
          Label(screen.rawValue, systemImage: screen.systemImage)
            .foregroundColor(screen == selectedScreen ? .white : .white.opacity(0.85))
            .listRowBackground(screen == selectedScreen ? Color.purple : Color.black)
            .listRowSeparatorTint(.white.opacity(0.4))
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .scrollDisabled(true)
        .linearBackground(colorScheme: colorScheme)
      } detail: {
        if let selectedScreen {
          selectedScreen.view(colorScheme: colorScheme)
        } else {
          Text("Please select a screen.")
        }
      }
      .navigationSplitViewStyle(.balanced)
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
