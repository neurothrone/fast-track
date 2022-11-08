//
//  ActiveWeekScreen.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-08.
//

import SwiftUI

struct ActiveWeekScreen: View {
  var body: some View {
    VStack(alignment: .leading) {
      Text("Active Fast")
        .font(.largeTitle)
      
      HStack {
        VStack {
          // If not started: Start button
          
          // Else
          Text("Start Time")
          
          // Replace with Swipe action?
          // Left : Stop.
          // Right: Reset
          Button("Stop") {}
            .buttonStyle(.borderedProminent)
        }
        
        Spacer()
        
        Text("Time: 18:52")
          .frame(width: 75, height: 75)
          .overlay(
            Circle()
              .fill(.purple.opacity(0.5))
          )
      }
      .padding()
      .background(
        RoundedRectangle(cornerRadius: 20)
          .fill(.secondary)
      )
      
      Text("Active Week")
        .font(.largeTitle)
      
      Text("Progress Bar")
        .padding(.vertical)
        .frame(maxWidth: .infinity)
      
      List {
        Text("Day 1 Monday - 4h")
        Text("Day 2 Tuesday - 3h")
      }
      
      Spacer()
    }
    .padding()
  }
}

struct ActiveWeekScreen_Previews: PreviewProvider {
  static var previews: some View {
    ActiveWeekScreen()
  }
}
