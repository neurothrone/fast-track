//
//  ActiveWeekScreen.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-08.
//

import SwiftUI

struct ActiveWeekScreen: View {
  @Environment(\.managedObjectContext) private var viewContext
  
  @AppStorage(Constants.AppStorage.weeklyFastingHoursGoal)
  private var weeklyHoursGoal: WeeklyFastingHoursGoal = .easy
  
  @AppStorage(Constants.AppStorage.datePickerDisplayMode)
  private var displayMode: DatePickerDisplayMode = .compact
  
  @FetchRequest(
    fetchRequest: FastLog.allCompletedInCurrentWeek,
    animation: .default
  )
  private var fastLogs: FetchedResults<FastLog>
  
  @State private var isAddManualLogPresented = false
  
  var body: some View {
    content
      .onChange(of: weeklyHoursGoal) { newWeeklyGoal in
        Week.changeWeeklyGoalForActiveWeek(
          weeklyGoal: newWeeklyGoal,
          using: viewContext
        )
      }
      .sheet(isPresented: $isAddManualLogPresented) {
        AddManualLogSheet()
      }
      .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
      .toolbar {
        Menu {
          Button(action: { isAddManualLogPresented.toggle() }) {
            Label("Add log manually", systemImage: "calendar.badge.plus")
          }
          
          Menu {
            ForEach(WeeklyFastingHoursGoal.allCases) { goal in
              Button(goal.toString) {
                weeklyHoursGoal = goal
              }
            }
          } label: {
            Label("Change Weekly Goal", systemImage: "target")
          }
        } label: {
          Image(systemName: "ellipsis.circle.fill")
        }
      }
  }
  
  private var content: some View {
    List {
      LogListProgressMeterView(
        label: "Fasted state hours",
        systemImage: "gauge",
        amount: FastLog.totalFastedStateToHours(in: Array(fastLogs)),
        min: .zero,
        max: Double(weeklyHoursGoal.hours),
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
  }
}

struct ActiveWeekScreen_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      ActiveWeekScreen()
        .linearBackground()
        .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
    }
  }
}
