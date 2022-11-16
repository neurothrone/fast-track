//
//  ActiveWeekScreen.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-08.
//

import SwiftUI

struct ActiveWeekScreen: View {
  @Environment(\.managedObjectContext) private var viewContext
  
  @FetchRequest(
    fetchRequest: FastLog.allCompletedInCurrentWeek,
    animation: .default
  )
  private var fastLogs: FetchedResults<FastLog>
  
  var body: some View {
    NavigationStack {
      content
        .linearBackground()
        .navigationTitle("Active Week")
        .navigationBarTitleDisplayMode(.inline)
    }
  }
  
  private var content: some View {
    List {
      LogListProgressMeterView(
        label: "Fasted state hours",
        systemImage: "gauge",
        amount: FastLog.totalFastedStateToHours(in: Array(fastLogs)),
        min: .zero,
        max: 24,
        progressColor: .purple
      )
      
      Section {
        SwipeableLogView()
          .listRowBackground(
            EmptyView()
              .background(.ultraThinMaterial)
          )
      }
      
      ActiveWeekLogListView(logs: fastLogs)
    }
    .scrollContentBackground(.hidden)
    .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
  }
}

struct ActiveWeekScreen_Previews: PreviewProvider {
  static var previews: some View {
    ActiveWeekScreen()
      .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
//          .preferredColorScheme(.dark)
  }
}
