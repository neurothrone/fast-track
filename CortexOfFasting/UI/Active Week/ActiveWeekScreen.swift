//
//  ActiveWeekScreen.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-08.
//

import SwiftUI

struct ActiveWeekScreen: View {
  @Environment(\.managedObjectContext) private var viewContext
  
  @FetchRequest(fetchRequest: FastLog.allInCurrentWeek, animation: .default)
  private var fastLogs: FetchedResults<FastLog>
  
  private var hasPartialLog: Bool {
    guard fastLogs.isNotEmpty,
          let incompleteLog = fastLogs.first,
          incompleteLog.stoppedDate == nil
    else { return false }
    
    return true
  }
  
  var body: some View {
    NavigationStack {
      content
        .navigationTitle("Active Week")
        .navigationBarTitleDisplayMode(.inline)
    }
  }
  
  private var content: some View {
    VStack(alignment: .leading) {
      Group {
        if hasPartialLog {
          ActiveLogView(log: fastLogs.first!, onStopTapped: completePartialFeedLog)
        } else {
          InactiveLogView(onStartTapped: createPartialFeedLog)
        }
      }
      .background(
        RoundedRectangle(cornerRadius: 20)
          .fill(.gray.opacity(0.75))
      )
      
      ProgressMeterView(
        label: "Fasted state hours",
        systemImage: "gauge",
        amount: FastLog.totalFastedStateToHours(in: Array(fastLogs)),
        min: .zero,
        max: 24
      )
      .padding(.vertical)
      
      List {
        ForEach(fastLogs) { log in
          ActiveWeekLogsRowView(log: log)
        }
      }
      
      Spacer()
    }
    .padding()
  }
}

extension ActiveWeekScreen {
  private func createPartialFeedLog() {
    let newLog = FastLog(context: viewContext)
    newLog.startedDate = .now
    newLog.save(using: viewContext)
  }
  
  private func completePartialFeedLog() {
    guard let incompleteLog = fastLogs.first else { return }
    
    incompleteLog.stoppedDate = .now
    incompleteLog.save(using: viewContext)
  }
}

struct ActiveWeekScreen_Previews: PreviewProvider {
  static var previews: some View {
    ActiveWeekScreen()
      .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
  }
}
