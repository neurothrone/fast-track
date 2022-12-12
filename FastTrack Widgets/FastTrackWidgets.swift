//
//  FastTrackWidgets.swift
//  FastTrack Widgets
//
//  Created by Zaid Neurothrone on 2022-12-05.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
  func placeholder(in context: Context) -> SimpleEntry {
    SimpleEntry(date: Date())
  }

  func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
    let entry = SimpleEntry(date: Date())
    completion(entry)
  }
  
  func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
    var entries: [SimpleEntry] = []

    // Generate a timeline consisting of five entries an hour apart, starting from the current date.
    let currentDate = Date()
    for hourOffset in 0 ..< 5 {
      let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
      let entry = SimpleEntry(date: entryDate)
      entries.append(entry)
    }

    let timeline = Timeline(entries: entries, policy: .atEnd)
    completion(timeline)
  }
  
//  @Environment(\.managedObjectContext) var moc
//
//  func placeholder(in context: Context) -> LogEntry {
//    LogEntry(date: Date())
//  }
//
//  func getSnapshot(in context: Context, completion: @escaping (LogEntry) -> ()) {
//    let entry = LogEntry(date: Date())
//    completion(entry)
//  }
//
//  func getTimeline(
//    in context: Context,
//    completion: @escaping (Timeline<Entry>) -> ()) {
//
//      let currentDate = Date()
//
//      let logEntry = fetch()
//
//      if logEntry.hasActiveLog {
//        let nextUpdate = Calendar.current.date(byAdding: .second, value: 1, to: currentDate)!
//
//        let timeline = Timeline(
//          entries: [logEntry],
//          policy: .after(nextUpdate)
//        )
//        completion(timeline)
//      }
//  }
  
//  func fetch() -> LogEntry {
//    let request = FastLog.incompleteLogs
//
//    let incompleteLogs: [FastLog]
//
//    do {
//      incompleteLogs = try moc.fetch(request)
//    } catch {
//      incompleteLogs = []
//    }
//
//    var logEntry = LogEntry()
//
//    if let activeLog = incompleteLogs.first {
//      logEntry.hasActiveLog = true
//      logEntry.log = activeLog
//    } else {
//      logEntry.log = .init()
//    }
//
//    return logEntry
//  }
}

struct SimpleEntry: TimelineEntry {
  let date: Date
}

struct LogEntry: TimelineEntry {
  var date: Date = .init()
  var hasActiveLog = false
  var log: FastLog = .init()
}

struct Lockscreen_WidgetsEntryView : View {
  @Environment(\.managedObjectContext) private var moc
  @Environment(\.widgetFamily) var widgetFamily
  
  @FetchRequest(
    fetchRequest: FastLog.incompleteLogs,
    animation: .default
  )
  private var incompleteLogs: FetchedResults<FastLog>
  
  @FetchRequest(
    fetchRequest: FastLog.allCompletedInCurrentWeek,
    animation: .default
  )
  private var completeLogs: FetchedResults<FastLog>
  
//  @FetchRequest(
//    fetchRequest: Week.activeWeekRequest(),
//    animation: .default
//  )
//  private var activeWeeks: FetchedResults<Week>

  var entry: Provider.Entry
  
  var body: some View {
    ZStack {
      AccessoryWidgetBackground()
      
      switch widgetFamily {
      case .systemSmall:
        ProgressMeterView(
          label: "Fasted state hours",
          systemImage: "gauge",
          amount: FastLog.totalFastedStateDurationToHours(in: Array(completeLogs)),
          min: .zero,
          max: Double(
            24
            //          activeWeeks.first?.goal ?? Int16(appState.weeklyHoursGoal.hours)
          ),
          progressColor: .purple
        )
      case .systemMedium:
        Group {
          if let activeLog = incompleteLogs.first {
            ActiveLogView(log: activeLog)
              .frame(width: .infinity)
          } else {
            Text("No active log yet.")
          }
        }
        .padding()
      case .systemLarge:
        List {
          if completeLogs.isEmpty {
            Text("No logs yet.")
          } else {
            ForEach(completeLogs) { log in
              Text(log.startedDate.inReadableFormat)
            }
          }
        }
        
      case .accessoryCircular:
        ProgressMeterView(
          label: "Fasted state hours",
          systemImage: "gauge",
          amount: FastLog.totalFastedStateDurationToHours(in: Array(completeLogs)),
          min: .zero,
          max: 24,
          progressColor: .purple
        )
      case .accessoryInline:
        if let activeLog = incompleteLogs.first {
          ActiveLogView(log: activeLog)
            .frame(width: .infinity)
        } else {
          Text("No active log yet.")
        }
      case .accessoryRectangular:
        if let activeLog = incompleteLogs.first {
          ActiveLogView(log: activeLog)
            .frame(width: .infinity)
        } else {
          Text("No active log yet.")
        }
      default:
        Text("Not Implemented")
      }
    }
  }
}

struct LockscreenWidgets: Widget {
  let kind: String = "Lockscreen_Widgets"
  
  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: Provider()) { entry in
      Lockscreen_WidgetsEntryView(entry: entry)
    }
    .configurationDisplayName("My Widget")
    .description("This is a FastTrack widget.")
    .supportedFamilies([
      .systemSmall,
      .systemMedium,
      .systemLarge,
      .accessoryInline,
      .accessoryCircular,
      .accessoryRectangular
    ])
  }
}

struct Lockscreen_Widgets_Previews: PreviewProvider {
  static var previews: some View {
    let context = CoreDataProvider.preview.viewContext
    let log = FastLog(context: context)
    log.startedDate = .now.subtracting(hours: 16)
    log.save(using: context)
    
    return Group {
      Lockscreen_WidgetsEntryView(entry: SimpleEntry(date: Date()))
        .previewContext(WidgetPreviewContext(family: .systemSmall))
        .previewDisplayName("System Small")
        .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
      
      Lockscreen_WidgetsEntryView(entry: SimpleEntry(date: Date()))
        .previewContext(WidgetPreviewContext(family: .systemMedium))
        .previewDisplayName("System Medium")
        .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
      
      Lockscreen_WidgetsEntryView(entry: SimpleEntry(date: Date()))
        .previewContext(WidgetPreviewContext(family: .accessoryInline))
        .previewDisplayName("Inline")
        .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
      
      Lockscreen_WidgetsEntryView(entry: SimpleEntry(date: Date()))
        .previewContext(WidgetPreviewContext(family: .accessoryCircular))
        .previewDisplayName("Circular")
        .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
      
      Lockscreen_WidgetsEntryView(entry: SimpleEntry(date: Date()))
        .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
        .previewDisplayName("Rectangular")
        .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
    }
  }
}
