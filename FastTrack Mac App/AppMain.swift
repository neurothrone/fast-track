//
//  AppMain.swift
//  FastTrack Mac App
//
//  Created by Zaid Neurothrone on 2022-12-07.
//

import SwiftUI

@main
struct AppMain: App {  
  private let coreDataProvider: CoreDataProvider = .shared
  
  var body: some Scene {
    Window("FastTrack", id: "main") {
      ContentView()
        .environment(\.managedObjectContext, coreDataProvider.viewContext)
        .onAppear {
          NSWindow.allowsAutomaticWindowTabbing = false
        }
        .onReceive(NotificationCenter.default.publisher(
          for: NSApplication.willTerminateNotification)
        ) { _ in
          CoreDataProvider.save(using: coreDataProvider.viewContext)
        }
    }
    .windowResizability(.contentSize)
    .commands { // Effectively hides the menu items
      CommandGroup(replacing: .newItem, addition: {})
      CommandGroup(replacing: .undoRedo, addition: {})
      CommandGroup(replacing: .pasteboard, addition: {})
    }

    MenuBarExtra {
      MenuBarExtraView()
        .environment(\.managedObjectContext, coreDataProvider.viewContext)
    } label: {
      Label("FastTrack", systemImage: "fork.knife")
    }
    .menuBarExtraStyle(.window)
    
    Settings(content: SettingsView.init)
  }
}
