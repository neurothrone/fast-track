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
  
  var body: some View {
    List {
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
          }
        }
      } header: {
        SectionHeaderView(leftText: "Fasting times", rightText: "Fasting duration")
      }
    }
    .listStyle(.plain)
  }
}

struct ActiveWeekScreen_Previews: PreviewProvider {
  static var previews: some View {
    ActiveWeekScreen()
      .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
  }
}
