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
}

