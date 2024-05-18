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
      .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
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
    }
  }
}
