//
//  WeekDetailScreen.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-08.
//

import SwiftUI

struct WeekDetailScreen: View {
  @Environment(\.managedObjectContext) private var viewContext
  
  let logs: SectionedFetchResults<String, FastLog>.Element
  
  var body: some View {
    VStack {
      ProgressMeterView(
        label: "Fasted state hours",
        systemImage: "gauge",
        amount: 12,
        min: .zero,
        max: 24
      )
      .padding()
      
      List {
        Section {
          ForEach(logs) { log in
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
            FastLog.delete(atOffsets: indexSet, section: logs, using: viewContext)
          }
        } header: {
          HStack {
            Text("Day")
            Spacer()
            Text("Fasting time")
          }
          .textCase(.none)
        }
      }
      .navigationTitle(logs.id)
    }
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
