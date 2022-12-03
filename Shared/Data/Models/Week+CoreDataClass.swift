//
//  Week+CoreDataClass.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-12-02.
//
//

import CoreData
import Foundation

@objc(Week)
public class Week: NSManagedObject {
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Week> {
    return NSFetchRequest<Week>(entityName: String(describing: Week.self))
  }
  
  @NSManaged public var date: Date
  @NSManaged public var goal: Int16
  @NSManaged public var logs: [FastLog]
}

// MARK: Generated accessors for logs
extension Week {
  @objc(addLogsObject:)
  @NSManaged public func addToLogs(_ value: FastLog)
  
  @objc(removeLogsObject:)
  @NSManaged public func removeFromLogs(_ value: FastLog)
  
  @objc(addLogs:)
  @NSManaged public func addToLogs(_ values: NSSet)
  
  @objc(removeLogs:)
  @NSManaged public func removeFromLogs(_ values: NSSet)
}

extension Week : Identifiable {}
