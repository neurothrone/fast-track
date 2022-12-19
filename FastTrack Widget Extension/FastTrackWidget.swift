//
//  FastTrackWidget.swift
//  FastTrack Widget Extension
//
//  Created by Zaid Neurothrone on 2022-12-17.
//

import CoreData
import SwiftUI
import WidgetKit

struct LogEntry: TimelineEntry {
  let date: Date
  var activeWeekLogs: [FastLog] = []
}

struct Provider: TimelineProvider {
  typealias Entry = LogEntry
  
  private var moc: NSManagedObjectContext
  
  init(context: NSManagedObjectContext) {
    self.moc = context
  }
  
  func placeholder(in context: Context) -> Entry {
    LogEntry(date: Date())
  }
  
  func getSnapshot(in context: Context, completion: @escaping (Entry) -> ()) {
    let entry = LogEntry(date: Date())
    completion(entry)
  }
  
  func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
    var logEntry = LogEntry(date: Date())
    
    do {
      let logs = try moc.fetch(FastLog.allCompletedInCurrentWeek)
      logEntry.activeWeekLogs = logs
    } catch {
      // Do nothing
    }

    let timeline = Timeline(
      entries: [logEntry],
      policy: .never
//      policy: activeLog != nil ? .after(.now.advanced(by: 1)) : .never
    )
    
    completion(timeline)
  }
}

struct FastTrackWidgetExtension: Widget {
  let kind: String = "FastTrackWidgetExtension"
  
  var body: some WidgetConfiguration {
    StaticConfiguration(
      kind: kind,
      provider: Provider(context: CoreDataProvider.shared.viewContext)
    ) { entry in
      FastTrackWidgetExtensionEntryView(entry: entry)
    }
    .configurationDisplayName("FastTrack Widget")
    .description("Widgets for tracking your active fasting.")
    .supportedFamilies([
//      .systemSmall,
//      .systemMedium,
//      .systemLarge,
//      .systemExtraLarge,
//      .accessoryInline,
//      .accessoryCircular,
//      .accessoryRectangular
    ])
  }
}

struct FastTrackWidgetExtensionEntryView : View {
  @AppStorage(
    Constants.AppStorage.weeklyFastingHoursGoal,
    store: UserDefaults(suiteName: CKConfig.sharedAppGroup)
  )
  private(set) var weeklyGoal: WeeklyFastingHoursGoal = .easy
  
  @Environment(\.widgetFamily) var widgetFamily
  
  var entry: Provider.Entry
  
  var body: some View {
    ZStack {
      AccessoryWidgetBackground()
      
      switch widgetFamily {
      case .systemSmall:
        VStack {
          WidgetProgressMeterView(
            label: "Fasted state hours",
            systemImage: "gauge",
            amount: Double(FastLog.totalFastedStateDurationToHours(in: entry.activeWeekLogs)),
            min: .zero,
            max: Double(weeklyGoal.hours),
            progressColor: .purple
          )
          
          if let activeLog = entry.activeWeekLogs.first,
             activeLog.stoppedDate == nil {
            Text(activeLog.startedDate, style: .timer)
              .multilineTextAlignment(.center)
          } else {
            Text("No active log yet.")
          }
        }
        .padding()
      case .systemExtraLarge:
        LazyVStack {
          ForEach(entry.activeWeekLogs) { log in
            Text(log.duration.inHoursAndMinutes)
          }
        }
        .padding(.horizontal)
      case .accessoryCircular:
        WidgetProgressMeterView(
          label: "Fasted state hours",
          systemImage: "gauge",
          amount: Double(FastLog.totalFastedStateDurationToHours(in: entry.activeWeekLogs)),
          min: .zero,
          max: Double(weeklyGoal.hours),
          progressColor: .purple
        )
      case .accessoryInline:
        Group {
          if let activeLog = entry.activeWeekLogs.first,
             activeLog.stoppedDate == nil {
            Text(activeLog.startedDate, style: .timer)
          } else {
            Text("No active log yet")
          }
        }
        .font(.headline)
      case .accessoryRectangular:
        Group {
          if let activeLog = entry.activeWeekLogs.first,
             activeLog.stoppedDate == nil {
            Text(activeLog.startedDate, style: .timer)
              .multilineTextAlignment(.center)
          } else {
            Text("No active log yet.")
          }
        }
        .font(.headline)
      default:
        Text("Not Implemented")
      }
    }
    .unredacted()
  }
}

//MARK: - Preview
struct FastTrackWidgetExtension_Previews: PreviewProvider {
  static var previews: some View {
    //MARK: - Home Screen Widget Previews
    
    FastTrackWidgetExtensionEntryView(
      entry: LogEntry(date: Date())
    )
    .previewContext(WidgetPreviewContext(family: .systemSmall))
    .previewDisplayName("System Small")
    
//          FastTrackWidgetExtensionEntryView(
//            entry: LogEntry(date: Date(), info: "Preview")
//          )
//          .previewContext(WidgetPreviewContext(family: .systemMedium))
//          .previewDisplayName("System Medium")
      
      //    FastTrackWidgetExtensionEntryView(
      //      entry: LogEntry(date: Date(), info: "Preview")
      //    )
      //    .previewContext(WidgetPreviewContext(family: .systemLarge))
      //    .previewDisplayName("System Large")
      //
//          FastTrackWidgetExtensionEntryView(
//            entry: LogEntry(date: Date())
//          )
//          .previewContext(WidgetPreviewContext(family: .systemExtraLarge))
//          .previewDisplayName("System Extra Large")
      
      //MARK: - Lockscreen Widget Previews
      
//      FastTrackWidgetExtensionEntryView(
//        entry: LogEntry(date: Date(), info: "Preview")
//      )
//      .previewContext(WidgetPreviewContext(family: .accessoryCircular))
//      .previewDisplayName("Accessory Circular")
      
//          FastTrackWidgetExtensionEntryView(
//            entry: LogEntry(date: Date(), info: "Preview")
//          )
//          .previewContext(WidgetPreviewContext(family: .accessoryInline))
//          .previewDisplayName("Accessory Inline")
      
//      FastTrackWidgetExtensionEntryView(
//        entry: LogEntry(date: Date(), info: "Preview")
//      )
//      .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
//      .previewDisplayName("Accessory Rectangular")
  }
}
