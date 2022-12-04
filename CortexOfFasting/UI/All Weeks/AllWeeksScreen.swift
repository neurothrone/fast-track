//
//  AllWeeksScreen.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-08.
//

import SwiftUI

struct AllWeeksScreen: View {
  @Environment(\.managedObjectContext) private var viewContext
  @EnvironmentObject private var appState: AppState
  
  @FetchRequest(fetchRequest: FastLog.allCompleted, animation: .default)
  private var fastLogs: FetchedResults<FastLog>
  
  @SectionedFetchRequest(
    fetchRequest: FastLog.allCompleted,
    sectionIdentifier: \FastLog.yearAndWeek,
    animation: .default)
  private var logsPerWeek: SectionedFetchResults<String, FastLog>
  
  var body: some View {
    content
      .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
  }
  
  private var content: some View {
    List {
      Section {
        ForEach(logsPerWeek) { logsInWeek in
          NavigationLink {
            WeekDetailScreen(logs: logsInWeek)
          } label: {
            HStack {
              Text(logsInWeek.id)
                .foregroundColor(.mint)
              
              Spacer()

              if let first = logsInWeek.first {
                Text("\(FastLog.totalFastedStateToHoursFormatted(in: Array(logsInWeek))) / \(first.week.goal) h")
                  .foregroundColor(.purple)
              }
            }
            .textCase(.none)
          }
        }
        .listRowBackground(Color.black)
      } header: {
        SectionHeaderView(leftText: "Week", rightText: "Fasted state hours")
      }
    }
    .scrollContentBackground(.hidden)
  }
}

struct AllWeeksScreen_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      AllWeeksScreen()
        .linearBackground()
        .navigationTitle(Screen.allWeeks.rawValue)
        .navigationBarTitleDisplayMode(.inline)
        .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
        .environmentObject(AppState())
    }
  }
}
