//
//  AppMain.swift
//  FastTrack Mac App
//
//  Created by Zaid Neurothrone on 2022-12-07.
//

import SwiftUI

@main
struct AppMain: App {
  var body: some Scene {
    Window("FastTrack", id: "main") {
      ContentView()
        .environment(\.managedObjectContext, CoreDataProvider.shared.viewContext)
        .onAppear {
          NSWindow.allowsAutomaticWindowTabbing = false
        }
    }
    .windowResizability(.contentSize)
    .commands { // Effectively hides the menu items
      CommandGroup(replacing: .newItem, addition: {})
      CommandGroup(replacing: .undoRedo, addition: {})
      CommandGroup(replacing: .pasteboard, addition: {})
    }

    MenuBarExtra("FastTrack", systemImage: "fork.knife.circle.fill") {
      VStack {
        Button("Start Fasting", action: {})
        Button("Add Manual Log", action: {})
      }
    }
    .menuBarExtraStyle(.menu)
    
    Settings(content: SettingsView.init)
  }
}
