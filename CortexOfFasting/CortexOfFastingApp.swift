//
//  CortexOfFastingApp.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-08.
//

import SwiftUI

@main
struct CortexOfFastingApp: App {
  @StateObject var dataManager = DataManager.shared
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(\.managedObjectContext, CoreDataProvider.shared.viewContext)
        .environmentObject(dataManager)
    }
  }
}
