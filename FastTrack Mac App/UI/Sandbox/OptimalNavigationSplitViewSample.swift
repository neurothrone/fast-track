//
//  OptimalNavigationSplitViewSample.swift
//  FastTrack Mac App
//
//  Created by Zaid Neurothrone on 2022-12-12.
//

import SwiftUI

struct OptimalNavigationSplitViewSample: View {
  private var items: [String] = [
    "Item 1",
    "Item 2",
    "Item 3",
    "Item 4",
    "Item 5",
  ]
  
  enum TopMenuItem: String, Identifiable, CaseIterable {
    case activeWeek = "Active Week",
         allWeeks = "All Weeks"
    
    var id: Self { self }
  }
  
  @State private var columnVisibility = NavigationSplitViewVisibility.doubleColumn
  @State private var topNav: TopMenuItem = .activeWeek
  
  var body: some View {
    NavigationSplitView(columnVisibility: $columnVisibility) {
      List {
        Text("Active Week")
        Text("All Weeks")
          .foregroundColor(.white)
      }
      .listStyle(.sidebar)
      
//      List(TopMenuItem.allCases, selection: $topNav) { nav in
//        Text(nav.rawValue)
//          .tag(nav)
//      }
    } content: {
      if topNav == .allWeeks {
        Text("Active Week")
      } else {
        List(items, id: \.self) { item in
          NavigationLink(item, value: item)
        }
        .listStyle(.inset(alternatesRowBackgrounds: true))
        .navigationDestination(for: String.self) { item in
          Text("\(item) at NavigationDestination")
        }
      }
    } detail: {
      Text("Please select an item")
    }
//    .navigationSplitViewStyle(.balanced)

//    NavigationSplitView {
//      List(logs) { log in
//        NavigationLink(log.startedDate.inReadableFormat, value: log)
//      }
//      .navigationDestination(for: FastLog.self) { log in
//        VStack {
//          Text(log.startedDate.inReadableFormat)
//
//          if let stoppedDate = log.stoppedDate {
//            Text(stoppedDate.inReadableFormat)
//            Text(log.duration.inHoursAndMinutes)
//          }
//        }
//      }
//    } detail: {
//        Text("Please select a log")
//    }
  }
}

struct OptimalNavigationSplitViewSample_Previews: PreviewProvider {
  static var previews: some View {
    OptimalNavigationSplitViewSample()
  }
}
