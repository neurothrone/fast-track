import SwiftUI

struct ActiveWeekLogListView: View {
  private enum ActiveSheet: Identifiable {
    case detail
    case edit(log: FastLog)
    
    var id: String {
      switch self {
      case .detail:
        return "1"
      case .edit(_):
        return "2"
      }
    }
  }
  
  @Environment(\.managedObjectContext) private var viewContext
  @State private var activeSheet: ActiveSheet?
  
  let logs: FetchedResults<FastLog>
  
  var body: some View {
    Section {
      if logs.isEmpty {
        Text("No logs in active week yet.")
          .foregroundColor(.mint)
          .listRowBackground(Color.black)
      } else {
        ForEach(logs) { log in
          LogListRowView(log: log)
            .swipeActions(edge: .leading, allowsFullSwipe: false) {
              Button("Edit") {
                activeSheet = .edit(log: log)
              }
              .tint(.orange)
            }
        }
        .onDelete(perform: deleteLog)
        .listRowBackground(Color.black)
        .listRowSeparatorTint(.white.opacity(0.4))
      }
    } header: {
      SectionHeaderView(leftText: "Fasting times", rightText: "Fasting duration")
    }
    .sheet(item: $activeSheet) { sheet in
      switch sheet {
      case .detail:
        Text("Detail View")
      case .edit(let log):
        EditLogSheet(log: log)
      }
    }
  }
}

extension ActiveWeekLogListView {
  private func deleteLog(atOffsets: IndexSet) {
    guard let index = atOffsets.first else { return }
    
    logs[index].delete(using: viewContext)
  }
}
