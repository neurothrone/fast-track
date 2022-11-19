//
//  CreatePartialLog.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-18.
//

import AppIntents
import SwiftUI

struct CreatePartialLog: AppIntent {
  // The name of the action in Shortcuts
  static var title: LocalizedStringResource = "Start Fasting"
  
  // Description of the action in Shortcuts
  // Category name allows you to group actions - shown when tapping on an app in the Shortcuts library
  static var description: IntentDescription = IntentDescription(
"""
Creates a fasting log.

A preview of the new log is optionally shown as a Snippet after the action has run.
""", categoryName: "Editing")
  
  @MainActor // <-- include if the code needs to be run on the main thread
  func perform() async throws -> some ReturnsValue<ShortcutsFastLogEntity> {
    let newPartialLog = FastLog.createPartialLog(using: CoreDataProvider.shared.viewContext)
    
    let shortcutEntity = ShortcutsFastLogEntity(id: newPartialLog.id, startedDate: newPartialLog.startedDate, stoppedDate: newPartialLog.stoppedDate)
    
    return .result(value: shortcutEntity) { // <-- we output the 'Log' to be used in the next shortcut action
      
      // Including a trailing closure with a SwiftUI view adds a 'Show When Run' button to the Shortcut action
      // If this is toggled, the view will be shown as a 'Snippet' then the result is output
      // A snippet is an archived SwiftUI View (similar to a medium-size widget)
      // You can use multiple Links() in Snippets which will open in the background
      // Like widgets, you cannot use animated or interactive elements like ScrollViews
      LogView(log: newPartialLog)
    }
  }
}
