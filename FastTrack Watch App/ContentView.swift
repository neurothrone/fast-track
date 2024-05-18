import SwiftUI

struct ContentView: View {
  @Environment(\.managedObjectContext) var viewContext
  @EnvironmentObject var cloudUserDefaults: CloudUserDefaults

  @FetchRequest(
    fetchRequest: FastLog.allCompletedInCurrentWeek,
    animation: .default
  )
  private var fastLogs: FetchedResults<FastLog>
  
  var body: some View {
    NavigationStack {
      content
        .navigationTitle(MyApp.name)
        .navigationBarTitleDisplayMode(.inline)
        .edgesIgnoringSafeArea(.bottom)
        .toolbar {
          ToolbarItem(placement: .confirmationAction) {
            NavigationLink(destination: ChangeWeeklyGoalView()) {
              Image(systemName: MyApp.SystemImage.target)
                .foregroundColor(.purple)
            }
          }
        }
    }
  }
  
  private var content: some View {
    VStack(alignment: .center, spacing: 20) {
      ProgressMeterView(
        label: "Fasted state hours",
        systemImage:  MyApp.SystemImage.gauge,
        amount: FastLog.totalFastedStateDurationToHours(in: Array(fastLogs)),
        min: .zero,
        max: Double(cloudUserDefaults.weeklyGoal.hours),
        progressColor: .purple
      )
      
      List {
        SwipeableLogView()
      }
      .scrollDisabled(true)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
      .environmentObject(CloudUserDefaults.shared)
  }
}
