//
//  WeekDetailScreen.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-08.
//

import SwiftUI

struct WeekDetailScreen: View {
  @Environment(\.managedObjectContext) private var viewContext
  
  let logs: SectionedFetchResults<String, FastLog>.Element
  
  var body: some View {
    NavigationStack {
      content
        .linearBackground()
        .navigationTitle(logs.id)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
    }
  }
  
  private var content: some View {
    List {
      Section {
        ForEach(logs) { log in
          LogListRowView(log: log)
        }
        .onDelete(perform: deleteLog)
        .listRowBackground(Color.black)
        .listRowSeparatorTint(.white.opacity(0.4))
      } header: {
        SectionHeaderView(leftText: "Day", rightText: "Fasting time")
      }
    }
    .scrollContentBackground(.hidden)
  }
}

extension WeekDetailScreen {
  private func deleteLog(atOffsets: IndexSet) {
    FastLog.delete(atOffsets: atOffsets, section: logs, using: viewContext)
  }
}
