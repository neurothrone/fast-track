//
//  AppMain.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-08.
//

import SwiftUI

@main
struct AppMain: App {
  @StateObject var appState: AppState = .init()
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(appState)
        .environment(\.managedObjectContext, CoreDataProvider.shared.viewContext)
    }
  }
}
