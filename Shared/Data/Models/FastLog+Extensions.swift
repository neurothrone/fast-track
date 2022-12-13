//
//  FastLog+Extensions.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-08.
//

import CoreData
import SwiftUI

extension FastLog {
  var duration: TimeInterval {
    guard let stoppedDate = stoppedDate
    else { return .zero }
    
    return startedDate.distance(to: stoppedDate)
  }
  
  static func createManualLog(
    startedDate: Date,
    stoppedDate: Date,
    using context: NSManagedObjectContext
  ) {
    let fastLog = FastLog(context: context)
    fastLog.startedDate = startedDate
    fastLog.stoppedDate = stoppedDate
    fastLog.save(using: context)
  }
  
  static func createPartialLog(using context: NSManagedObjectContext) -> FastLog {
    let newPartialLog = FastLog(context: context)
    newPartialLog.startedDate = .now
    newPartialLog.save(using: context)
    
    return newPartialLog
  }
  
  static func completePartialLog(for log: FastLog, using context: NSManagedObjectContext) {
    log.stoppedDate = .now
    log.save(using: context)
  }
  
  static func resetPartialLog(for log: FastLog, using context: NSManagedObjectContext) {
    log.startedDate = .now
    log.save(using: context)
  }
  
  static func findLog(withId id: String, using context: NSManagedObjectContext) throws -> FastLog {
    let request: NSFetchRequest<FastLog> = FastLog.fetchRequest()
    request.fetchLimit = 1
    request.predicate = NSPredicate(format: "id = %@", id as CVarArg)
    
    do {
      guard let foundLog = try context.fetch(request).first else {
        throw CustomError.notFound
      }
      
      return foundLog
    } catch {
      throw CustomError.notFound
    }
  }
  
  static func getAllLogs(using context: NSManagedObjectContext) -> [FastLog] {
    let request: NSFetchRequest<FastLog> = FastLog.fetchRequest()
    
    do {
      return try context.fetch(request).sorted(by: { $0.startedDate > $1.startedDate })
    } catch let error {
      print("Couldn't fetch all logs: \(error.localizedDescription)")
      return []
    }
  }
  
  static var allCompleted: NSFetchRequest<FastLog> {
    let request: NSFetchRequest<FastLog> = NSFetchRequest(entityName: String(describing: FastLog.self))
    request.predicate = NSPredicate(format: "stoppedDate != nil")
    request.sortDescriptors = [NSSortDescriptor(keyPath: \FastLog.startedDate, ascending: false)]
    return request
  }
  
  static var allCompletedInCurrentWeek: NSFetchRequest<FastLog> {
    let request: NSFetchRequest<FastLog> = NSFetchRequest(entityName: String(describing: FastLog.self))
    
    request.sortDescriptors = [NSSortDescriptor(keyPath: \FastLog.startedDate, ascending: false)]
    
    let calendar = Calendar.current
    let startOfWeek = Date.now.startOfWeek(using: calendar)
    let endOfWeek = calendar.date(byAdding: .day, value: 7, to: startOfWeek) ?? .now
    
    let datesInRangePredicate = NSPredicate(
      format: "startedDate >= %@ AND startedDate < %@",
      startOfWeek as CVarArg,
      endOfWeek as CVarArg
    )

    request.predicate = datesInRangePredicate
    return request
  }
  
  static func getIncompleteLog(using context: NSManagedObjectContext) throws -> FastLog? {
    let request: NSFetchRequest<FastLog> = incompleteLogs
    return try context.fetch(request).first
  }
  
  static var incompleteLogs: NSFetchRequest<FastLog> {
    let request: NSFetchRequest<FastLog> = NSFetchRequest(entityName: String(describing: FastLog.self))
    request.fetchLimit = 1
    request.sortDescriptors = [NSSortDescriptor(keyPath: \FastLog.startedDate, ascending: false)]
    request.predicate = NSPredicate(format: "stoppedDate == nil")
    return request
  }
  
  static func totalFastedStateDurationToSeconds(in fastLogs: [FastLog]) -> TimeInterval {
    let minHoursToFastedState: TimeInterval = 12 * 60 * 60
    
    let totalFastedStateSeconds = fastLogs.reduce(TimeInterval.zero) { partialResult, log in
      if log.duration > minHoursToFastedState {
        let fastedStateTime = log.duration - minHoursToFastedState
        return partialResult + fastedStateTime
      }
      
      return partialResult
    }
    
    return totalFastedStateSeconds
  }
  
  static func totalFastedStateDurationToHours(in fastLogs: [FastLog]) -> Double {
    let totalFastedStateSeconds = FastLog.totalFastedStateDurationToSeconds(in: fastLogs)
    let totalFastedStateHours = totalFastedStateSeconds / 60.0 / 60.0
    return round(totalFastedStateHours * 10) / 10.0
  }
  
  static func totalFastedStateDurationToHoursFormatted(in fastLogs: [FastLog]) -> String {
    let totalFastedStateHours = totalFastedStateDurationToHours(in: fastLogs)
    return String(format: "%.1f", totalFastedStateHours)
  }
  
  static func delete(
    atOffsets: IndexSet,
    section: SectionedFetchResults<String, FastLog>.Element,
    using context: NSManagedObjectContext
  ) {
    guard let index = atOffsets.first else { return }
    
    section[index].delete(using: context)
  }
  
  static func deleteAll(
    at section: SectionedFetchResults<String, FastLog>.Element,
    using context: NSManagedObjectContext
  ) {
    section.forEach { log in
      context.delete(log)
    }
    
    do {
      try context.save()
    } catch {
      context.rollback()
      print("❌ -> Failed to delete Log on \(#function).")
    }
  }
  
  static func deleteAll(using context: NSManagedObjectContext) {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: FastLog.self))
    let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    batchDeleteRequest.resultType = .resultTypeObjectIDs

    guard let result = try? context.execute(batchDeleteRequest) as? NSBatchDeleteResult else { return }

    let changes: [AnyHashable: Any] = [NSDeletedObjectsKey: result.result as! [NSManagedObjectID]]
    NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [context])
  }
}

