//
//  AllWeeksScreen.swift
//  FastTrack Mac App
//
//  Created by Zaid Neurothrone on 2022-12-07.
//

import SwiftUI

struct AllWeeksScreen: View {
  @Environment(\.managedObjectContext) private var viewContext

  @SectionedFetchRequest(
    fetchRequest: FastLog.allCompleted,
    sectionIdentifier: \FastLog.yearAndWeek,
    animation: .default
  )
  private var logsPerWeek: SectionedFetchResults<String, FastLog>
  
  var body: some View {
    LogSectionedListView(logsPerWeek: logsPerWeek)
  }
}

struct AllWeeksScreen_Previews: PreviewProvider {
  static var previews: some View {
    AllWeeksScreen()
      .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
  }
}
