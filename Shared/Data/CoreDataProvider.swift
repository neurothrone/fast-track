//
//  CoreDataProvider.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-08.
//

import CoreData

private struct CKConfig {
  private init() {}
  
  static let containerName = "Entities"
  static let sharedAppGroup = "group.cortexOfFasting"
  static let cloudContainerID = "iCloud.cortexOfFasting"
}

final class CoreDataProvider {
  static let shared: CoreDataProvider = .init()

  static var preview: CoreDataProvider = {
    let provider = CoreDataProvider(inMemory: true)
    
    FastLog.Preview.createSamples(using: provider.viewContext)
    
    return provider
  }()
  
  private let inMemory: Bool
  
  private lazy var container: NSPersistentCloudKitContainer = {
    let container = NSPersistentCloudKitContainer(name: CKConfig.containerName)
    
    let storeURL = URL.storeURL(
      for: CKConfig.sharedAppGroup,
      databaseName: CKConfig.containerName
    )
    
    if inMemory {
      container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
    } else {
      let storeDescription = NSPersistentStoreDescription(url: storeURL)
      storeDescription.setOption(
        true as NSNumber,
        forKey: NSPersistentHistoryTrackingKey
      )
      storeDescription.setOption(
        true as NSNumber,
        forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey
      )
      
      storeDescription.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(
        containerIdentifier: CKConfig.cloudContainerID)
      container.persistentStoreDescriptions = [storeDescription]
    }
    
    container.loadPersistentStores { store, error in
      if let error = error as NSError? {
        fatalError("❌ -> Unresolved error \(error), \(error.userInfo)")
      }
    }
    
    container.viewContext.automaticallyMergesChangesFromParent = true
    container.viewContext.name = "viewContext"
    container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    container.viewContext.undoManager = nil
    container.viewContext.shouldDeleteInaccessibleFaults = true
    
    return container
  }()
  
  init(inMemory: Bool = false) {
    self.inMemory = inMemory
  }
  
  var viewContext: NSManagedObjectContext { container.viewContext }
  
//  let container: NSPersistentContainer
  
//  init(inMemory: Bool = false) {
//    container = NSPersistentContainer(name: "Entities")
//
//    if inMemory {
//      container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
//    }
//
//    container.loadPersistentStores { _, error in
//      if let error = error as NSError? {
//        assertionFailure("❌ -> Unresolved error \(error), \(error.userInfo)")
//      }
//    }
//
//    container.viewContext.automaticallyMergesChangesFromParent = true
//    container.viewContext.name = "viewContext"
//    container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
//    container.viewContext.undoManager = nil
//    container.viewContext.shouldDeleteInaccessibleFaults = true
//  }
}

