//
//  ColumnAppStorage.swift
//  FastTrack iOS App
//
//  Created by Zaid Neurothrone on 2022-12-12.
//

import SwiftUI

struct ColumnAppStorage: View {
  @AppStorage("columnVisibility") private var column: NavigationSplitViewVisibility = .detailOnly
  
  private let choices: [NavigationSplitViewVisibility] = [
    .all,
    .doubleColumn,
    .detailOnly,
    .automatic
    ]
  
  var body: some View {
    NavigationSplitView(columnVisibility: $column) {
      List {
        Text("Item 1")
        Text("Item 2")
        Text("Item 3")
      }
    } detail: {
      VStack(spacing: 10) {
        Text("Detail")
        
        Button("All") {
          column = .all
        }
        
        Button("Double Column") {
          column = .doubleColumn
        }
        
        Button("Detail Only") {
          column = .detailOnly
        }
        
        Button("Automatic") {
          column = .automatic
        }
      }
      .buttonStyle(.borderedProminent)
    }
    .navigationSplitViewStyle(.balanced)
  }
}

struct ColumnAppStorage_Previews: PreviewProvider {
  static var previews: some View {
    ColumnAppStorage()
  }
}
