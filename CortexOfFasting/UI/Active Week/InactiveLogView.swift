//
//  InactiveLogView.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-08.
//

import SwiftUI

struct InactiveLogView: View {
  let onStartTapped: () -> Void
  
  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text("No active fast yet. Press the button to start.")
        
        Button("Start", action: onStartTapped)
          .buttonStyle(.borderedProminent)
          .tint(.blue)
      }
      
      Spacer()
    }
    .padding()
  }
}

struct InactiveLogView_Previews: PreviewProvider {
  static var previews: some View {
    InactiveLogView(onStartTapped: {})
  }
}
