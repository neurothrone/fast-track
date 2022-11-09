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
        .linearBackground()
        .navigationTitle("Active Week")
        .navigationBarTitleDisplayMode(.inline)
    }
  }
  
  private var content: some View {
    VStack(alignment: .leading, spacing: .zero) {
      Group {
        if hasPartialLog {
          ActiveLogView(log: fastLogs.first!, onStopTapped: completePartialFeedLog)
        } else {
          InactiveLogView(onStartTapped: createPartialFeedLog)
        }
      }
      .background(.ultraThinMaterial)
      .cornerRadius(20)
      .padding(.horizontal)
      
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
            ForEach(fastLogs) { log in
              ActiveWeekLogsRowView(log: log)
            }
            .listRowBackground(Color.black)
          } header: {
            SectionHeaderView(leftText: "Fasting times", rightText: "Fasting duration")
          }
        }
        .scrollContentBackground(.hidden)
      }
      
      Spacer()
    }
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
    //      .preferredColorScheme(.dark)
  }
}
