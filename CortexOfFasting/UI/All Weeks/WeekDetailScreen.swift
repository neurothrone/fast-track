//
//  WeekDetailScreen.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-08.
//

import SwiftUI

struct WeekDetailScreen: View {
  @Environment(\.managedObjectContext) private var viewContext
  
//  @AppStorage(Constants.AppStorage.weeklyFastingHoursGoal)
//  private var weeklyHoursGoal: WeeklyFastingHoursGoal = .easy
  
  let logs: SectionedFetchResults<String, FastLog>.Element
  
  var body: some View {
    NavigationStack {
      content
        .linearBackground()
        .navigationTitle(logs.id)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
    }
  }
  
  private var content: some View {
    List {
      LogListProgressMeterView(
        label: "Fasted state hours",
        systemImage: "gauge",
        amount: FastLog.totalFastedStateToHours(in: Array(logs)),
        min: .zero,
        max: Double(logs.first?.week.goal ?? .zero),
//        max: Double(weeklyHoursGoal.hours),
        progressColor: .purple
      )
      
      Section {
        ForEach(logs) { log in
          LogListRowView(log: log)
        }
        .onDelete(perform: deleteLog)
        .listRowBackground(Color.black)
        .listRowSeparatorTint(.white.opacity(0.4))
      } header: {
        SectionHeaderView(leftText: "Day", rightText: "Fasting time")
      }
    }
    .scrollContentBackground(.hidden)
  }
}

extension WeekDetailScreen {
  private func deleteLog(atOffsets: IndexSet) {
    FastLog.delete(atOffsets: atOffsets, section: logs, using: viewContext)
  }
}

//struct WeekDetailScreen_Previews: PreviewProvider {
//  static var previews: some View {
//    let context = CoreDataProvider.preview.viewContext
//    let logs
//    
//    WeekDetailScreen()
//      .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
//  }
//}
