//
//  AllWeeksScreen.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-08.
//

import SwiftUI

struct AllWeeksScreen: View {
  @Environment(\.managedObjectContext) private var viewContext
  
  @FetchRequest(fetchRequest: FastLog.all, animation: .default)
  private var fastLogs: FetchedResults<FastLog>
  
  @SectionedFetchRequest(
    fetchRequest: FastLog.all,
    sectionIdentifier: \FastLog.yearAndWeek,
    animation: .default)
  private var logsPerWeek: SectionedFetchResults<String, FastLog>
  
  var body: some View {
    NavigationStack {
      content
        .navigationTitle("All Weeks")
    }
  }
  
  private var content: some View {
    List {
      ForEach(logsPerWeek) { logsInWeek in
        Section {
          ForEach(logsInWeek) { log in
            HStack {
              Text(log.startedDate.formatted(Date.FormatStyle()
                .day()
                .weekday()
                .month())
              )
              
              Spacer()
              
              Text(log.duration.inHoursAndMinutes)
            }
          }
          .onDelete { indexSet in
            deleteLog(atOffsets: indexSet, section: logsInWeek)
          }
        } header: {
          HStack {
            Text(logsInWeek.id)
            
            Spacer()
            
            let totalSecondsOfWeek = logsInWeek.reduce(TimeInterval.zero) { partialResult, log in
              return partialResult + log.duration
            }
            let shortHours = String(format: "%.1f", totalSecondsOfWeek / 60.0 / 60.0)
            Text("\(shortHours) / 24 h")
          }
          .font(.headline)
          .textCase(.none)
        }
      }
    }
  }
}

extension AllWeeksScreen {
  private func deleteLog(
    atOffsets: IndexSet,
    section: SectionedFetchResults<String, FastLog>.Element
  ) {
    guard let index = atOffsets.first else { return }
    
    section[index].delete(using: viewContext)
  }
}

struct AllWeeksScreen_Previews: PreviewProvider {
  static var previews: some View {
    AllWeeksScreen()
      .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
  }
}
