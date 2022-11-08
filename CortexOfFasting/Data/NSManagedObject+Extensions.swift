//
//  NSManagedObject+Extensions.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-08.
//

import CoreData

extension NSManagedObject {
  private static var viewContext: NSManagedObjectContext {
    CoreDataProvider.shared.viewContext
  }
  
  func save(using context: NSManagedObjectContext) {
    CoreDataProvider.save(using: context)
  }
  
  func delete(using context: NSManagedObjectContext) {
    CoreDataProvider.delete(object: self, using: context)
  }
}
