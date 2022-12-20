//
//  ActiveWeekScreen.swift
//  FastTrack Mac App
//
//  Created by Zaid Neurothrone on 2022-12-07.
//

import SwiftUI

struct ActiveWeekScreen: View {
  @Environment(\.managedObjectContext) private var viewContext
  @EnvironmentObject private var cloudUserDefaults: CloudUserDefaults

  @FetchRequest(
    fetchRequest: FastLog.allCompletedInCurrentWeek,
    animation: .default
  )
  private var fastLogs: FetchedResults<FastLog>
  
  @State private var selectedLog: FastLog?
  @State private var isAddManualLogSheetPresented = false  
  
  var body: some View {
    content
      .sheet(isPresented: $isAddManualLogSheetPresented) {
        AddManualLogSheet()
      }
      .toolbar {
        Button {
          isAddManualLogSheetPresented.toggle()
        } label: {
          Label("Add Manual Log", systemImage: "plus")
        }
        
        DeleteButtonView(selectedLog: $selectedLog)
      }
  }
  
  private var content: some View {
    List(selection: $selectedLog) {
      ProgressMeterView(
        label: "Fasted state hours",
        systemImage: "gauge",
        amount: FastLog.totalFastedStateDurationToHours(in: Array(fastLogs)),
        min: .zero,
        max: Double(cloudUserDefaults.weeklyGoal.hours),
        progressColor: .purple
      )
      .padding(.bottom)
      
      Divider()
      
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

struct ActiveWeekScreen_Previews: PreviewProvider {
  static var previews: some View {
    ActiveWeekScreen()
      .environmentObject(CloudUserDefaults.shared)
  }
}
