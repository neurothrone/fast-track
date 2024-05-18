import SwiftUI

//MARK: - Equatable and Hashable conformance so selection is possible on macOS
#if os(macOS)
extension SectionedFetchResults<String, FastLog>.Element: Equatable, Hashable {
  public static func ==(lhs: SectionedFetchResults<String, FastLog>.Element, rhs: SectionedFetchResults<String, FastLog>.Element) -> Bool {
    lhs.id == rhs.id
  }
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(self.id)
  }
}
#endif

struct LogSectionedListView: View {
  @Environment(\.managedObjectContext) var moc
  
#if os(macOS)
  @State private var selectedSection: SectionedFetchResults<String, FastLog>.Element?
#endif
  
  let logsPerWeek: SectionedFetchResults<String, FastLog>
  
  var body: some View {
#if os(iOS)
    List {
      content
    }
    .scrollContentBackground(.hidden)
#else
    List(selection: $selectedSection) {
      content
    }
    .listStyle(.plain)
    .toolbar {
      Button(role: .destructive, action: deleteSelected) {
        Label("Delete", systemImage: "trash")
      }
      .keyboardShortcut(.delete, modifiers: [])
      .disabled(selectedSection == nil)
    }
#endif
  }
  
  private var content: some View {
    Section {
      if logsPerWeek.isEmpty {
        Text("No logs yet.")
#if os(iOS)
          .foregroundColor(.mint)
          .listRowBackground(Color.black)
#endif
      } else {
        ForEach(logsPerWeek) { logsInWeek in
#if os(iOS)
          NavigationLink {
            WeekDetailScreen(logs: logsInWeek)
          } label: {
            LogSectionedListRowView(
              yearWeekLabel: logsInWeek.id,
              totalFastedStateDuration: FastLog.totalFastedStateDurationToHours(
                in: Array(logsInWeek))
            )
          }
          .listRowBackground(Color.black)
#elseif os(macOS)
          LogSectionedListRowView(
            yearWeekLabel: logsInWeek.id,
            totalFastedStateDuration: FastLog.totalFastedStateDurationToHours(
              in: Array(logsInWeek))
          )
          .listRowSeparator(.visible)
          .listRowSeparatorTint(.white.opacity(0.2), edges: .all)
          .alignmentGuide(.listRowSeparatorLeading) { viewDimensions in
            return .zero
          }
          .contextMenu {
            Button("Delete", role: .destructive) {
              FastLog.deleteAll(at: logsInWeek, using: moc)
            }
          }
          .tag(logsInWeek)
#endif
        }
#if os(iOS)
        .onDelete(perform: delete)
#endif
      }
    } header: {
      SectionHeaderView(leftText: "Year (Week)", rightText: "Fasted state hours")
    }
  }
}

extension LogSectionedListView {
#if os(macOS)
  private func deleteSelected() {
    if let selectedSection {
      FastLog.deleteAll(at: selectedSection, using: moc)
    }
  }
#endif
  
  private func delete(at offsets: IndexSet) {
    guard let index = offsets.first else { return }
    
    FastLog.deleteAll(at: logsPerWeek[index], using: moc)
  }
}

//struct LogSectionedListView_Previews: PreviewProvider {
//  static var previews: some View {
//    LogSectionedListView()
//  }
//}
