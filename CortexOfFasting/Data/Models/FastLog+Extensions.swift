//
//  FastLog+Extensions.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-08.
//

import CoreData
import SwiftUI

extension FastLog {
  var startedAt: String {
    startedDate.formatted()
  }
  
  var stoppedAt: String {
    stoppedDate?.formatted() ?? ""
  }
  
  var duration: TimeInterval {
    guard let stoppedDate = stoppedDate
    else { return .zero }
    
    return startedDate.distance(to: stoppedDate)
  }
  
  static var all: NSFetchRequest<FastLog> {
    let request: NSFetchRequest<FastLog> = NSFetchRequest(entityName: String(describing: FastLog.self))
    request.sortDescriptors = [NSSortDescriptor(keyPath: \FastLog.startedDate, ascending: false)]
    return request
  }
  
  static var allCompletedInCurrentWeek: NSFetchRequest<FastLog> {
    let request: NSFetchRequest<FastLog> = NSFetchRequest(entityName: String(describing: FastLog.self))
    
    request.sortDescriptors = [NSSortDescriptor(keyPath: \FastLog.startedDate, ascending: false)]
    
    let calendar = Calendar.current
    let startOfWeek = Date.now.startOfWeek(using: calendar)
    let endOfWeek = calendar.date(byAdding: .day, value: 7, to: startOfWeek) ?? .now
    
    let currentWeekPredicate = NSPredicate(format: "startedDate >= %@ AND startedDate < %@", startOfWeek as CVarArg, endOfWeek as CVarArg)
    let onlyCompletedLogsPredicate = NSPredicate(format: "stoppedDate != nil")
    let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
      currentWeekPredicate,
      onlyCompletedLogsPredicate]
    )
    
    request.predicate = compoundPredicate

    return request
  }
  
  static var firstIncompleteLog: NSFetchRequest<FastLog> {
    let request: NSFetchRequest<FastLog> = NSFetchRequest(entityName: String(describing: FastLog.self))
    request.fetchLimit = 1
    request.sortDescriptors = [NSSortDescriptor(keyPath: \FastLog.startedDate, ascending: false)]
    request.predicate = NSPredicate(format: "stoppedDate == nil")
    return request
  }
  
  static func totalFastedStateSeconds(in fastLogs: [FastLog]) -> TimeInterval {
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
  
  static func totalFastedStateToHours(in fastLogs: [FastLog]) -> Double {
    let totalFastedStateSeconds = FastLog.totalFastedStateSeconds(in: fastLogs)
    let totalFastedStateHours = totalFastedStateSeconds / 60.0 / 60.0
    return round(totalFastedStateHours * 10) / 10.0
  }
  
  static func totalFastedStateToHoursFormatted(in fastLogs: [FastLog]) -> String {
    let totalFastedStateHours = totalFastedStateToHours(in: fastLogs)
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
}

