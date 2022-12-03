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
      
      let week = Week.getOrCreateWeekOf(date: fastLog.startedDate, with: .easy, using: context)
      week.addToLogs(fastLog)
      week.save(using: context)
    }
    
    static func createSamplesForCurrentWeek(using context: NSManagedObjectContext) {
      let calendar = Calendar.current
      let today = Date.now
      
      let startOfWeek = today.startOfWeek(using: calendar)
      let days = calendar.numberOfDaysBetween(startOfWeek, and: today)
      let endOfWeek = calendar.date(byAdding: .day, value: days, to: startOfWeek) ?? today
      
      let week = Week.getOrCreateWeekOf(date: today, with: .legendary, using: context)
      
      let dayDurationInSeconds: TimeInterval = 60 * 60 * 24
      for startedDate in stride(from: startOfWeek, to: endOfWeek, by: dayDurationInSeconds) {
        let fastLog = FastLog(context: context)
        
        fastLog.startedDate = startedDate
        fastLog.stoppedDate = startedDate.adding(minutes: Int.random(in: 600...1_000))
        
        week.addToLogs(fastLog)
      }
      
      week.save(using: context)
    }
    
    static func createSamplesForWeekOf(
      date: Date,
      with weeklyGoal: WeeklyFastingHoursGoal,
      using context: NSManagedObjectContext
    ) {
      let calendar = Calendar.current
      
      let startOfWeek = date.startOfWeek(using: calendar)
      
      let lastDayOfWeek = calendar.date(
        from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: startOfWeek)
      ) ?? startOfWeek
      let endOfWeek = calendar.date(byAdding: .day, value: 7, to: lastDayOfWeek) ?? lastDayOfWeek
      
      let week = Week.getOrCreateWeekOf(date: date, with: weeklyGoal, using: context)
      
      let dayDurationInSeconds: TimeInterval = 60 * 60 * 24
      for startedDate in stride(from: startOfWeek, to: endOfWeek, by: dayDurationInSeconds) {
        let fastLog = FastLog(context: context)
        
        fastLog.startedDate = startedDate
        fastLog.stoppedDate = startedDate.adding(minutes: Int.random(in: 600...1_000))
        
        week.addToLogs(fastLog)
      }
      
      week.save(using: context)
    }
    
    static func createSamplesForManyWeeks(using context: NSManagedObjectContext) {
      let calendar = Calendar.current
      let components = DateComponents(calendar: calendar, year: 2022, month: 11, day: 1)
      
      let firstDayOfNovember = calendar.date(from: components) ?? .now
      
      let firstWeekOfNovember = firstDayOfNovember.startOfWeek(using: calendar)
      let secondWeekOfNovember = calendar.date(byAdding: .day, value: 7, to: firstWeekOfNovember) ?? .now
      let thirdWeekOfNovember = calendar.date(byAdding: .day, value: 7, to: secondWeekOfNovember) ?? .now
      let fourthWeekOfNovember = calendar.date(byAdding: .day, value: 7, to: thirdWeekOfNovember) ?? .now

      let firstWeekDays = [
        firstWeekOfNovember,
        secondWeekOfNovember,
        thirdWeekOfNovember,
        fourthWeekOfNovember
      ]
      
      let weeklyGoals: [WeeklyFastingHoursGoal] = [
        .easy,
        .normal,
        .hard,
        .legendary
      ]

      for (firstWeekDay, weeklyGoal) in zip(firstWeekDays, weeklyGoals) {
        createSamplesForWeekOf(date: firstWeekDay, with: weeklyGoal, using: context)
      }
    }
  }
}

