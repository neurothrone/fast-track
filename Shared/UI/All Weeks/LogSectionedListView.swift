//
//  LogSectionedListView.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-12-11.
//

import SwiftUI

struct LogSectionedListView: View {
  let logsPerWeek: SectionedFetchResults<String, FastLog>
  
  var body: some View {
    List {
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
#endif
          }
        }
      } header: {
        SectionHeaderView(leftText: "Year (Week)", rightText: "Fasted state hours")
      }
    }
#if os(iOS)
    .scrollContentBackground(.hidden)
#elseif os(macOS)
    .listStyle(.plain)
#endif
  }
}

//struct LogSectionedListView_Previews: PreviewProvider {
//  static var previews: some View {
//    LogSectionedListView()
//  }
//}
