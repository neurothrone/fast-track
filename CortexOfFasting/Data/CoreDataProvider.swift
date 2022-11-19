//
//  CoreDataProvider.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-08.
//

import CoreData

final class CoreDataProvider {
  static let shared: CoreDataProvider = .init()

  static var preview: CoreDataProvider = {
    let provider = CoreDataProvider(inMemory: true)
    let context = provider.container.viewContext
    FastLog.Preview.createSamples(using: context)
    return provider
  }()
  
  let container: NSPersistentContainer
  
  var viewContext: NSManagedObjectContext { container.viewContext }
  
  init(inMemory: Bool = false) {
    container = NSPersistentContainer(name: "Entities")
    
    if inMemory {
      container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
    }
    
    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        assertionFailure("❌ -> Unresolved error \(error), \(error.userInfo)")
      }
    }
    
    container.viewContext.automaticallyMergesChangesFromParent = true
    container.viewContext.name = "viewContext"
    container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    container.viewContext.undoManager = nil
    container.viewContext.shouldDeleteInaccessibleFaults = true
  }
}

