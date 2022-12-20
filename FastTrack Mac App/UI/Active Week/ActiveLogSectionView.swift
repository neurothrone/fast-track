//
//  ActiveLogSectionView.swift
//  FastTrack Mac App
//
//  Created by Zaid Neurothrone on 2022-12-12.
//

import SwiftUI

struct ActiveLogSectionView: View {
  @Environment(\.managedObjectContext) var moc
  
  @FetchRequest(
    fetchRequest: FastLog.incompleteLogs,
    animation: .default
  )
  private var incompleteLogs: FetchedResults<FastLog>
  
  var body: some View {
    Section {
      if incompleteLogs.isNotEmpty,
         let activeLog = incompleteLogs.first {
        ActiveLogView(log: activeLog)
          .padding(.top, 5)
      } else {
        Text("No active log yet.")
      }
    } header: {
      HStack(alignment: .firstTextBaseline) {
        SectionHeaderView(leftText: "Active Log")
        
        Spacer()

        Menu("Actions") {
          if incompleteLogs.isEmpty {
            Button(action: startFasting) {
              Label("Start fasting", systemImage: MyApp.SystemImage.startClock)
            }
          } else {
            Button(action: stopFasting) {
              Label("Stop fasting", systemImage: MyApp.SystemImage.stopClock)
            }
            
            Button(action: resetFasting) {
              Label("Reset fasting", systemImage: MyApp.SystemImage.resetClock)
            }
          }
        }
        .menuStyle(.button)
        .fixedSize()
      }
    }
  }
}

extension ActiveLogSectionView {
  private func startFasting() {
    _ = FastLog.createPartialLog(using: moc)
  }
  
  private func stopFasting() {
    guard let incompleteLog = incompleteLogs.first else { return }
    
    FastLog.completePartialLog(for: incompleteLog, using: moc)
  }
  
  private func resetFasting() {
    guard let incompleteLog = incompleteLogs.first else { return }
    
    FastLog.resetPartialLog(for: incompleteLog, using: moc)
  }
}

struct ActiveLogSectionView_Previews: PreviewProvider {
  static var previews: some View {
    ActiveLogSectionView()
  }
}
