//
//  WeekDetailScreen.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-08.
//

import SwiftUI

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

struct WeekDetailScreen_Previews: PreviewProvider {
  static var previews: some View {
    WeekDetailScreen()
  }
}
