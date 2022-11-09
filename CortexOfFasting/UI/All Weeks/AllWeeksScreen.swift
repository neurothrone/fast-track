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
        .linearBackground()
        .navigationTitle("All Weeks")
        .navigationBarTitleDisplayMode(.inline)
    }
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
              
              Spacer()
              
              Text("\(FastLog.totalFastedStateToHoursFormatted(in: Array(logsInWeek))) / 24 h")
            }
            .textCase(.none)
          }
        }
      } header: {
        HStack {
          Text("Week")
          Spacer()
          Text("Fasted state hours")
        }
        .textCase(.none)
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
