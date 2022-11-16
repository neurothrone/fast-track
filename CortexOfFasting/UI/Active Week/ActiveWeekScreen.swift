//
//  ActiveWeekScreen.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-08.
//

import SwiftUI

struct ActiveWeekScreen: View {
  @Environment(\.managedObjectContext) private var viewContext
  
  @AppStorage(Constants.AppStorage.datePickerDisplayMode)
  private var displayMode: DatePickerDisplayMode = .compact
  
  @FetchRequest(
    fetchRequest: FastLog.allCompletedInCurrentWeek,
    animation: .default
  )
  private var fastLogs: FetchedResults<FastLog>
  
  @State private var isAddManualLogPresented = false
  
  var body: some View {
    NavigationStack {
      content
        .linearBackground()
        .navigationTitle("Active Week")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isAddManualLogPresented) {
          AddManualLogSheet()
            .presentationDetents(
              displayMode == .compact
              ? [.fraction(0.25), .medium, .large]
              : [.large]
            )
        }
        .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
        .toolbar {
          Menu {
            Button(action: { isAddManualLogPresented.toggle() }) {
              Label("Add log manually", systemImage: "calendar.badge.plus")
            }
          } label: {
            Image(systemName: "ellipsis.circle")
          }
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
  }
}

struct ActiveWeekScreen_Previews: PreviewProvider {
  static var previews: some View {
    ActiveWeekScreen()
      .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
//          .preferredColorScheme(.dark)
  }
}
