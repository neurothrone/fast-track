//
//  SwipeableLogView.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-11.
//

import SwiftUI

struct SwipeableLogView: View {
  @Environment(\.managedObjectContext) private var viewContext
  
  @FetchRequest(
    fetchRequest: FastLog.incompleteLogs,
    animation: .default
  )
  private var incompleteLogs: FetchedResults<FastLog>
  
  @State private var isTimerRunning = false

  var hasPartialLog: Bool {
    if let incompleteLog = incompleteLogs.first,
       incompleteLog.stoppedDate == nil {
      return true
    }
    
    return false
  }
  
  var body: some View {
    Group {
      if isTimerRunning,
         let incompleteLog = incompleteLogs.first {
        ActiveLogView(log: incompleteLog)
      } else {
        Text("No active log yet. Swipe in from left to begin.")
          .padding(.vertical)
      }
    }
    .padding(.vertical)
    .onAppear(perform: checkForPartialLog)
    .onChange(of: incompleteLogs.first) { _ in
      checkForPartialLog()
    }
    .swipeActions(edge: .leading, allowsFullSwipe: false) {
      Button(action: isTimerRunning
             ? completePartialLog
             : createPartialLog
      ) {
        Label(isTimerRunning
              ? "Stop"
              : "Start",
              systemImage: isTimerRunning
              ? MyApp.SystemImage.stopClock
              : MyApp.SystemImage.startClock
        )
      }
      .tint(.purple)
    }
    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
      Button(action: resetPartialLog) {
        Label("Reset", systemImage: MyApp.SystemImage.resetClock)
      }
      .disabled(!isTimerRunning)
      .tint(.orange)
    }
  }
}

extension SwipeableLogView {
  private func checkForPartialLog() {
    isTimerRunning = hasPartialLog
  }
  
  private func createPartialLog() {
    _ = FastLog.createPartialLog(using: viewContext)
    
    isTimerRunning = true
  }
  
  private func completePartialLog() {
    guard let incompleteLog = incompleteLogs.first else { return }
    
    isTimerRunning = false
    
    FastLog.completePartialLog(for: incompleteLog, using: viewContext)
  }
  
  private func resetPartialLog() {
    guard let incompleteLog = incompleteLogs.first else { return }
    
    FastLog.resetPartialLog(for: incompleteLog, using: viewContext)
  }
}

struct SwipeableLogView_Previews: PreviewProvider {
  static var previews: some View {
    SwipeableLogView()
      .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
      .padding()
//      .linearBackground()
//      .preferredColorScheme(.dark)
  }
}
