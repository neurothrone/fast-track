import SwiftUI

@main
struct AppMain: App {  
  @StateObject private var cloudUserDefaults: CloudUserDefaults = .shared
  
  private let coreDataProvider: CoreDataProvider = .shared

  var body: some Scene {
    Window("FastTrack", id: "main") {
      ContentView()
        .environment(\.managedObjectContext, coreDataProvider.viewContext)
        .environmentObject(cloudUserDefaults)
        .onAppear {
          NSWindow.allowsAutomaticWindowTabbing = false
          cloudUserDefaults.setUp()
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
