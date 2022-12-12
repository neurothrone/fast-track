//
//  ActiveWeekScreen.swift
//  FastTrack Mac App
//
//  Created by Zaid Neurothrone on 2022-12-07.
//

import SwiftUI

struct ActiveWeekScreen: View {
  @Environment(\.managedObjectContext) private var viewContext

  @FetchRequest(
    fetchRequest: FastLog.allCompletedInCurrentWeek,
    animation: .default
  )
  private var fastLogs: FetchedResults<FastLog>
  
  @State private var selectedLog: FastLog?
  
  var body: some View {
    content
      .toolbar {
        Button(action: {}) { // TODO: addManualLog
          Label("Add Manual Log", systemImage: "plus")
        }
        
        Button(role: .destructive, action: deleteSelected) {
          Label("Delete", systemImage: "trash")
        }
        .keyboardShortcut(.delete, modifiers: [])
        .disabled(selectedLog == nil)
      }
  }
  
  private var content: some View {
    List(selection: $selectedLog) {
      ActiveLogSectionView()
      
      Section {
        if fastLogs.isEmpty {
          Text("No logs in active week yet.")
        } else {
          ForEach(fastLogs) { log in
            LogListRowView(log: log)
              .listRowSeparator(.visible)
              .listRowSeparatorTint(.white.opacity(0.2), edges: .all)
              .alignmentGuide(.listRowSeparatorLeading) { viewDimensions in
                return .zero
              }
              .contextMenu {
                Button("Delete", role: .destructive) {
                  log.delete(using: viewContext)
                }
              }
              .tag(log)
          }
        }
      } header: {
        SectionHeaderView(leftText: "Fasting times", rightText: "Fasting duration")
      }
    }
    .listStyle(.plain)
  }
}

extension ActiveWeekScreen {
  private func deleteSelected() {
    if let selectedLog {
      selectedLog.delete(using: viewContext)
    }
  }
}

struct ActiveWeekScreen_Previews: PreviewProvider {
  static var previews: some View {
    ActiveWeekScreen()
  }
}
