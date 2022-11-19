//
//  ShortcutsFastLogEntity.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-18.
//

import AppIntents
import CoreData
import Foundation

struct ShortcutsFastLogEntity: Identifiable, Hashable, Equatable, AppEntity {
  static var typeDisplayRepresentation: TypeDisplayRepresentation = .init(name: "FastLog")
  static var defaultQuery: IntentsFastLogQuery = .init()
  typealias DefaultQuery = IntentsFastLogQuery
  
  var id: String
  
  @Property(title: "Started Date")
  var startedDate: Date
  
  @Property(title: "Stopped Date")
  var stoppedDate: Date?
  
  init(id: String, startedDate: Date, stoppedDate: Date?) {
    self.id = id
    self.startedDate = startedDate
    self.stoppedDate = stoppedDate ?? nil
  }
  
  var displayRepresentation: DisplayRepresentation {
    .init(title: "\(startedDate.formatted())")
  }
}

extension ShortcutsFastLogEntity {
  // Hashable conformance
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
  // Equatable conformance
  static func ==(lhs: ShortcutsFastLogEntity, rhs: ShortcutsFastLogEntity) -> Bool {
    lhs.id == rhs.id
  }
}


struct IntentsFastLogQuery: EntityPropertyQuery {
  func entities(for identifiers: [String]) async throws -> [ShortcutsFastLogEntity] {
    identifiers.compactMap { identifier in
      if let match = try? FastLog.findLog(withId: identifier, using: CoreDataProvider.shared.viewContext) {
        return ShortcutsFastLogEntity(
          id: match.id,
          startedDate: match.startedDate,
          stoppedDate: match.stoppedDate)
      } else {
        return nil
      }
    }
  }
  
  func suggestedEntities() async throws -> [ShortcutsFastLogEntity] {
    let allLogs = FastLog.getAllLogs(using: CoreDataProvider.preview.viewContext)
    
    return allLogs.map {
      .init(id: $0.id, startedDate: $0.startedDate, stoppedDate: $0.stoppedDate)
    }
  }
  
  static var properties = EntityQueryProperties<ShortcutsFastLogEntity, NSPredicate> {
    Property(\ShortcutsFastLogEntity.$startedDate) {
      LessThanComparator { NSPredicate(format: "startedDate < %@", $0 as NSDate) }
      GreaterThanComparator { NSPredicate(format: "startedDate > %@", $0 as NSDate) }
    }
    Property(\ShortcutsFastLogEntity.$stoppedDate) {
      LessThanComparator { NSPredicate(format: "stoppedDate < %@", $0 as NSDate) }
      GreaterThanComparator { NSPredicate(format: "stoppedDate > %@", $0 as NSDate) }
    }
  }
  
  static var sortingOptions = SortingOptions {
    SortableBy(\ShortcutsFastLogEntity.$startedDate)
    SortableBy(\ShortcutsFastLogEntity.$stoppedDate)
  }
  
  func entities(
    matching comparators: [NSPredicate],
    mode: ComparatorMode,
    sortedBy: [Sort<ShortcutsFastLogEntity>],
    limit: Int?
  ) async throws -> [ShortcutsFastLogEntity] {
    let context = CoreDataProvider.shared.viewContext
    
    let request: NSFetchRequest<FastLog> = FastLog.fetchRequest()
    request.fetchLimit = limit ?? 5
    
    let predicate = NSCompoundPredicate(type: mode == .and ? .and : .or, subpredicates: comparators)
    request.predicate = predicate
    
    request.sortDescriptors = [NSSortDescriptor(keyPath: \FastLog.startedDate, ascending: false)]
    
    let matchingLogs = try context.fetch(request)
    
    return matchingLogs.map {
      .init(id: $0.id, startedDate: $0.startedDate, stoppedDate: $0.stoppedDate)
    }
  }
}
