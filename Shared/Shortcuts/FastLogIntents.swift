import AppIntents

@available(iOS 16, *)

let context = CoreDataProvider.shared.viewContext

struct StartFastingIntent: AppIntent {
  static let title: LocalizedStringResource = "Start fasting"
  static let description = IntentDescription("Starts a new active fasting session")
  static var openAppWhenRun: Bool = false
  
  @MainActor
  func perform() async throws -> some IntentResult {
    let incompleteLog: FastLog?
    
    do {
      incompleteLog = try FastLog.getIncompleteLog(using: context)
    } catch {
      return .result(dialog: "Failed to retrieve incomplete Fast logs from Core Data.")
    }
    
    guard incompleteLog == nil else {
      return .result(dialog: "There is already an active fasting.")
    }
    
    _ = FastLog.createPartialLog(using: context)
    return .result(dialog: "Your fasting has begun.")
  }
}

struct StopFastingIntent: AppIntent {
  static let title: LocalizedStringResource = "Stop fasting"
  static let description = IntentDescription("Completes your current active fasting")
  static var openAppWhenRun: Bool = false
  
  @MainActor
  func perform() async throws -> some IntentResult {
    let incompleteLog: FastLog?
    
    do {
      incompleteLog = try FastLog.getIncompleteLog(using: context)
    } catch {
      return .result(dialog: "Failed to retrieve incomplete Fast logs from Core Data.")
    }
    
    if let incompleteLog {
      FastLog.completePartialLog(for: incompleteLog, using: context)
      return .result(dialog: "You have completed your fasting.")
    } else {
      return .result(dialog: "No active fasting found.")
    }
  }
}

struct ResetFastingIntent: AppIntent {
  static let title: LocalizedStringResource = "Reset fasting"
  static let description = IntentDescription("Resets the start time of your active fasting to now")
  static var openAppWhenRun: Bool = false
  
  @MainActor
  func perform() async throws -> some IntentResult {
    let incompleteLog: FastLog?
    
    do {
      incompleteLog = try FastLog.getIncompleteLog(using: context)
    } catch {
      return .result(dialog: "Failed to retrieve incomplete Fast logs from Core Data.")
    }
    
    if let incompleteLog {
      FastLog.resetPartialLog(for: incompleteLog, using: context)
      return .result(dialog: "Your fasting start time has been reset to now.")
    } else {
      return .result(dialog: "No active fasting found.")
    }
  }
}
