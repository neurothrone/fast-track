//
//  FastLog+Preview.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-08.
//

import CoreData
import Foundation

extension FastLog {
  enum Preview {
    static func createSample(using context: NSManagedObjectContext) {
      let fastLog = FastLog(context: context)
      fastLog.startedDate = .now.subtracting(hours: 2)
      CoreDataProvider.save(using: context)
    }
    
    static func createSamples(using context: NSManagedObjectContext) {
      let calendar = Calendar.current
      
      let today = Date.now
      let startOfWeek = today.startOfWeek(using: calendar)
      let todayWeekDayNumber = calendar.component(.weekday, from: today)
      
      let endOfWeek = calendar.date(byAdding: .day, value: todayWeekDayNumber, to: startOfWeek) ?? .now
      
      let dayDurationInSeconds: TimeInterval = 60 * 60 * 24
      for startedDate in stride(from: startOfWeek, to: endOfWeek, by: dayDurationInSeconds) {
        let fastLog = FastLog(context: context)
        fastLog.startedDate = startedDate
        fastLog.stoppedDate = startedDate.adding(minutes: Int.random(in: 600...1_000))
        CoreDataProvider.save(using: context)
      }
    }
  }
}

