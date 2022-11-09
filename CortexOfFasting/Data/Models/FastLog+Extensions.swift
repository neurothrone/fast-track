//
//  FastLog+Extensions.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-08.
//

import CoreData

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
}

extension FastLog {
  static var all: NSFetchRequest<FastLog> {
    let request: NSFetchRequest<FastLog> = NSFetchRequest(entityName: String(describing: FastLog.self))
    request.sortDescriptors = [NSSortDescriptor(keyPath: \FastLog.startedDate, ascending: false)]
    return request
  }
  
  static var allInCurrentWeek: NSFetchRequest<FastLog> {
    let request: NSFetchRequest<FastLog> = NSFetchRequest(entityName: String(describing: FastLog.self))
    
    request.sortDescriptors = [NSSortDescriptor(keyPath: \FastLog.startedDate, ascending: false)]
    
    let calendar = Calendar.current
    
    let startOfWeek = Date.now.startOfWeek(using: calendar)
    let endOfWeek = calendar.date(byAdding: .day, value: 7, to: startOfWeek) ?? .now
    
    request.predicate = NSPredicate(format: "startedDate >= %@ AND startedDate < %@", startOfWeek as CVarArg, endOfWeek as CVarArg)
    
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
  
  static func totalFastedStateToHours(in fastLogs: [FastLog]) -> String {
    let totalFastedStateSeconds = FastLog.totalFastedStateSeconds(in: fastLogs)
    return String(format: "%.1f", totalFastedStateSeconds / 60.0 / 60.0)
  }
}

