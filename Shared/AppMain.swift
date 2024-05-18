import SwiftUI

@main
struct AppMain: App {
  @StateObject private var cloudUserDefaults: CloudUserDefaults = .shared
  
  var body: some Scene {
    WindowGroup {
      Group {
#if os(iOS)
        Group {
          if cloudUserDefaults.isFirstTimeUsingApp {
            SetWeeklyGoalView()
          } else {
            ContentView()
              .environment(\.managedObjectContext, CoreDataProvider.shared.viewContext)
          }
        }
        .environmentObject(cloudUserDefaults)
#else
        ContentView()
          .environment(\.managedObjectContext, CoreDataProvider.shared.viewContext)
          .environmentObject(cloudUserDefaults)
#endif
      }
      .onAppear(perform: cloudUserDefaults.setUp)
    }
  }
}
