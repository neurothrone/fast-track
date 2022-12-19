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
    
    FastLog.Preview.createSamplesForManyWeeks(using: provider.viewContext)
    FastLog.Preview.createSamplesForCurrentWeek(using: provider.viewContext)
    
    return provider
  }()
  
  private let inMemory: Bool
  
  private lazy var container: NSPersistentCloudKitContainer = {
    let container = NSPersistentCloudKitContainer(name: MyApp.CKConfig.containerName)
    
    #if os(macOS)
    
    #else
    let storeURL = URL.storeURL(
      for: MyApp.CKConfig.sharedAppGroup,
      databaseName: MyApp.CKConfig.containerName
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
        containerIdentifier: MyApp.CKConfig.cloudContainerID)
      container.persistentStoreDescriptions = [storeDescription]
    }
#endif
    
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
}

