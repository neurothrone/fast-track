//
//  ActiveWeekScreen.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-08.
//

import SwiftUI

struct ActiveWeekScreen: View {
  @Environment(\.managedObjectContext) var viewContext
  @EnvironmentObject var cloudUserDefaults: CloudUserDefaults

  @AppStorage(MyApp.AppStorage.datePickerDisplayMode)
  private var displayMode: DatePickerDisplayMode = .compact
  
  @FetchRequest(
    fetchRequest: FastLog.allCompletedInCurrentWeek,
    animation: .default
  )
  private var fastLogs: FetchedResults<FastLog>
  
  @State private var isAddManualLogPresented = false
  
  var body: some View {
    content
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
              Button {
                cloudUserDefaults.weeklyGoal = goal
              } label: {
                if cloudUserDefaults.weeklyGoal == goal {
                  Label(goal.toString, systemImage: "checkmark")
                } else {
                  Text(goal.toString)
                }
              }
            }
          } label: {
            Label("Change Weekly Goal", systemImage: "target")
          }
        } label: {
          Image(systemName: "ellipsis.circle")
        }
      }
  }
  
  private var content: some View {
    List {
      LogListProgressMeterView(
        label: "Fasted state hours",
        systemImage: MyApp.SystemImage.target,
        amount: FastLog.totalFastedStateDurationToHours(in: Array(fastLogs)),
        min: .zero,
        max: Double(cloudUserDefaults.weeklyGoal.hours),
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
        .environmentObject(CloudUserDefaults.shared)
    }
  }
}
