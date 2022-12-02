//
//  AppMain.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-08.
//

import SwiftUI

@main
struct AppMain: App {
  init() {
    print("ℹ️ -> \(AppShortcuts.appShortcuts)")
  }
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(\.managedObjectContext, CoreDataProvider.shared.viewContext)
    }
  }
}
