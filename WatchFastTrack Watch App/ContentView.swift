//
//  ContentView.swift
//  WatchFastTrack Watch App
//
//  Created by Zaid Neurothrone on 2022-12-02.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationStack {
      content
        .navigationTitle(Constants.App.name)
    }
  }
  
  private var content: some View {
    List(Screen.allCases) { screen in
      NavigationLink(
        destination: screen.view(withLinearBackground: false)
      ) {
        HStack {
          Image(systemName: screen.systemImage)
            .imageScale(.large)
            .foregroundColor(.purple)
          Text(screen.rawValue)
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
  }
}
