//
//  CompleteFastingIntent.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-18.
//

//import AppIntents
//
//struct CompleteFastingIntent: AppIntent {
//  static let title: LocalizedStringResource = "Complete fasting log"
//  static var description = IntentDescription("Jumps you right into the app, and completes a fasting log.")
//  static var openAppWhenRun: Bool = true
//
//  func perform() async throws -> some ReturnsValue & ProvidesDialog {
//    let newPartialLog = FastLog.completePartialLog(using: CoreDataProvider.shared.viewContext)
//
//    return .result(
//      value: newPartialLog.startedDate,
//      dialog: "\(newPartialLog.startedDate.inReadableFormat)"
//    )
//  }
//}
