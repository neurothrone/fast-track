//
//  ActiveWeekLogListView.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-12.
//

import SwiftUI

struct ActiveWeekLogListView: View {
  @Environment(\.managedObjectContext) private var viewContext
  
  let logs: FetchedResults<FastLog>
  
  var body: some View {
    Section {
      ForEach(logs) {
        LogListRowView(log: $0)
      }
      .onDelete(perform: deleteLog)
      .listRowBackground(Color.black)
      .listRowSeparatorTint(.white.opacity(0.4))
    } header: {
      SectionHeaderView(leftText: "Fasting times", rightText: "Fasting duration")
    }
  }
}

extension ActiveWeekLogListView {
  private func deleteLog(atOffsets: IndexSet) {
    guard let index = atOffsets.first else { return }
    
    logs[index].delete(using: viewContext)
  }
}

//struct ActiveWeekLogListView_Previews: PreviewProvider {
//  static var previews: some View {
//    ActiveWeekLogListView()
//      .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
//  }
//}
