//
//  ActiveWeekLogListView.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-12.
//

import SwiftUI

struct ActiveWeekLogListView: View {
  @Environment(\.managedObjectContext) private var viewContext
  
  @FetchRequest(
    fetchRequest: FastLog.allCompletedInCurrentWeek,
    animation: .default
  )
  private var fastLogs: FetchedResults<FastLog>
  
  var body: some View {
    VStack {
      ProgressMeterView(
        label: "Fasted state hours",
        systemImage: "gauge",
        amount: FastLog.totalFastedStateToHours(in: Array(fastLogs)),
        min: .zero,
        max: 24
      )
      .padding()
      .background(.ultraThinMaterial)
      .cornerRadius(20)
      .padding()
      
      if fastLogs.isNotEmpty {
        List {
          Section {
            ForEach(fastLogs) {
              ActiveWeekLogsRowView(log: $0)
            }
            .onDelete(perform: deleteLog)
            .listRowBackground(Color.black)
            .listRowSeparatorTint(.white.opacity(0.4))
          } header: {
            SectionHeaderView(leftText: "Fasting times", rightText: "Fasting duration")
          }
        }
        .scrollContentBackground(.hidden)
        
      } else {
        Text("No logs for this week yet...")
      }
    }
  }
}

extension ActiveWeekLogListView {
  private func deleteLog(atOffsets: IndexSet) {
    guard let index = atOffsets.first else { return }
    
    fastLogs[index].delete(using: viewContext)
  }
}

struct ActiveWeekLogListView_Previews: PreviewProvider {
  static var previews: some View {
    ActiveWeekLogListView()
      .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
  }
}
