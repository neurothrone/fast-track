//
//  Week+Extensions.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-12-02.
//

//import CoreData
//import Foundation
//
//extension Week {
//  static func getAllWeeks(using context: NSManagedObjectContext) -> [Week] {
//    let request: NSFetchRequest<Week> = Week.fetchRequest()
//    
//    do {
//      return try context.fetch(request)
//    } catch let error {
//      print("❌ -> Failed to fetch Week entities. Error: \(error.localizedDescription)")
//      return []
//    }
//  }
//  
//  static func activeWeekRequest(
//    date: Date = .now
//  ) -> NSFetchRequest<Week> {
//    let request: NSFetchRequest<Week> = Week.fetchRequest()
//    
//    let calendar = Calendar.current
//    let startOfWeek = date.startOfWeek(using: calendar)
//    let endOfWeek = calendar.date(byAdding: .day, value: 7, to: startOfWeek) ?? date
//    
//    let datesInRangePredicate = NSPredicate(
//      format: "date >= %@ AND date < %@",
//      startOfWeek as CVarArg,
//      endOfWeek as CVarArg
//    )
//        
//    request.predicate = datesInRangePredicate
//    request.sortDescriptors = [NSSortDescriptor(keyPath: \Week.date, ascending: true)]
//    request.fetchLimit = 1
//    
//    return request
//  }
//  
//  static func changeWeeklyGoalForActiveWeek(
//    weeklyGoal: WeeklyFastingHoursGoal,
//    using context: NSManagedObjectContext
//  ) {
//    let week = getOrCreateActiveWeek(using: context)
//    week.goal = Int16(weeklyGoal.hours)
//    week.save(using: context)
//  }
//  
//  static func getOrCreateActiveWeek(
//    with weeklyGoal: WeeklyFastingHoursGoal = .easy,
//    using context: NSManagedObjectContext
//  ) -> Week {
//    getOrCreateWeekOf(date: .now, with: weeklyGoal, using: context)
//  }
//  
//  static func getOrCreateWeekOf(
//    date: Date,
//    with weeklyGoal: WeeklyFastingHoursGoal = .easy,
//    using context: NSManagedObjectContext
//  ) -> Week {
//    let request: NSFetchRequest<Week> = Week.activeWeekRequest(date: date)
//    let weeks: [Week]
//    
//    do {
//      weeks = try context.fetch(request)
//    } catch {
//      weeks = []
//    }
//    
//    if let activeWeek = weeks.first {
//      return activeWeek
//    } else {
//      // Create a Week entity
//      let week = Week(context: context)
//      
//      let calendar = Calendar.current
//      let startOfWeek = date.startOfWeek(using: calendar)
//      
//      week.date = startOfWeek
//      week.goal = Int16(weeklyGoal.hours)
//      week.save(using: context)
//      
//      return week
//    }
//  }
//  
//  static func deleteAll(using context: NSManagedObjectContext) {
//    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Week.self))
//    let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//    batchDeleteRequest.resultType = .resultTypeObjectIDs
//
//    guard let result = try? context.execute(batchDeleteRequest) as? NSBatchDeleteResult else { return }
//
//    let changes: [AnyHashable: Any] = [NSDeletedObjectsKey: result.result as! [NSManagedObjectID]]
//    NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [context])
//  }
//}
