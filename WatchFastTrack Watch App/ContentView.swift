//
//  ContentView.swift
//  WatchFastTrack Watch App
//
//  Created by Zaid Neurothrone on 2022-12-02.
//

import SwiftUI

struct ContentView: View {
  @Environment(\.managedObjectContext) private var viewContext
  @EnvironmentObject private var appState: AppState
  
  @FetchRequest(
    fetchRequest: FastLog.allCompletedInCurrentWeek,
    animation: .default
  )
  private var fastLogs: FetchedResults<FastLog>
  
  @FetchRequest(
    fetchRequest: Week.activeWeekRequest(),
    animation: .default
  )
  private var activeWeeks: FetchedResults<Week>
  
  var body: some View {
    NavigationStack {
      content
        .navigationTitle(Constants.App.name)
        .navigationBarTitleDisplayMode(.inline)
        .edgesIgnoringSafeArea(.bottom)
    }
  }
  
  private var content: some View {
    VStack(alignment: .center, spacing: 20) {
      ProgressMeterView(
        label: "Fasted state hours",
        systemImage: "gauge",
        amount: FastLog.totalFastedStateToHours(in: Array(fastLogs)),
        min: .zero,
        max: Double(
          activeWeeks.first?.goal ?? Int16(appState.weeklyHoursGoal.hours)
        ),
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
      .environmentObject(AppState())
  }
}
