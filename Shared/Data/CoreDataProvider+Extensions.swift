//
//  CoreDataProvider+Extensions.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-08.
//

import CoreData

extension CoreDataProvider {
  static func save(using context: NSManagedObjectContext) {
    guard context.hasChanges else { return }
    
    do {
      try context.save()
    } catch {
      context.rollback()
      let nsError = error as NSError
      assertionFailure("❌ -> Failed to save context. Error: \(nsError), \(nsError.userInfo)")
    }
  }
  
  static func delete<T: NSManagedObject>(
    object: T,
    using context: NSManagedObjectContext
  ) {
    context.delete(object)
    save(using: context)
  }
}

