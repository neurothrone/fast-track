//
//  StartFastingIntent.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-18.
//

import AppIntents

struct StartFastingIntent: AppIntent {
  static let title: LocalizedStringResource = "Start fasting log"
  static var description = IntentDescription("Jumps you right into the app, and creates a fasting log with a timer.")
  static var openAppWhenRun: Bool = true
  
  func perform() async throws -> some ReturnsValue & ProvidesDialog {
    let newPartialLog = FastLog.createPartialLog(using: CoreDataProvider.shared.viewContext)
    
    return .result(
      value: newPartialLog.startedDate,
      dialog: "\(newPartialLog.startedDate.inReadableFormat)"
    )
  }
}
