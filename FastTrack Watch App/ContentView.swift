//
//  ContentView.swift
//  FastTrack Watch App
//
//  Created by Zaid Neurothrone on 2022-12-06.
//

import SwiftUI

struct ContentView: View {
  @Environment(\.managedObjectContext) private var viewContext

  @FetchRequest(
    fetchRequest: FastLog.allCompletedInCurrentWeek,
    animation: .default
  )
  private var fastLogs: FetchedResults<FastLog>
  
//  @StateObject private var connector: WatchConnector = .shared
  @StateObject private var cloudUserDefaults: CloudUserDefaults = .shared
  
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
        amount: FastLog.totalFastedStateDurationToHours(in: Array(fastLogs)),
        min: .zero,
        max: Double(cloudUserDefaults.weeklyGoal.hours),
//        max: Double(connector.weeklyGoal.hours),
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
  }
}
