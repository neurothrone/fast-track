//
//  AllWeeksScreen.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-08.
//

import SwiftUI

struct AllWeeksScreen: View {
  var body: some View {
    NavigationStack {
      List {
        NavigationLink {
          WeekDetailScreen()
        } label: {
          HStack {
            Text("Week 5")
            Spacer()
            Text("16 / 24 h")
          }
        }
      }
      .navigationTitle("All Weeks")
    }
  }
}

struct WeekDetailScreen: View {
  var body: some View {
    List {
      Section {
        HStack {
          VStack {
            Text("Start Time")
            Text("Stop Time")
          }
          
          Spacer()
          
          VStack {
            Text("Duration")
            Text("Fasted Hours")
          }
        }
      } header: {
        Text("Weekday (e.g. Monday) & Date")
      }
    }
    .navigationTitle("Week 5")
  }
}

struct AllWeeksScreen_Previews: PreviewProvider {
  static var previews: some View {
    AllWeeksScreen()
  }
}
