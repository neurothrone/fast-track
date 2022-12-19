//
//  AddManualLogSheet.swift
//  FastTrack Mac App
//
//  Created by Zaid Neurothrone on 2022-12-12.
//

import SwiftUI

struct AddManualLogSheet: View {
  @Environment(\.dismiss) var dismiss
  
  @State private var startedDate: Date = .now
  @State private var stoppedDate: Date = .now
  
  var body: some View {
    NavigationStack {
      Form {
        DatePicker("Started fasting", selection: $startedDate)
          .datePickerStyle(.compact)
        
        DatePicker("Stopped fasting", selection: $stoppedDate, in: .now...)
          .datePickerStyle(.compact)
        
        HStack {
          Button("Cancel", role: .cancel) {
            dismiss()
          }
          .buttonStyle(.bordered)
          
          Spacer()
          
          Button("Add") {
            // TODO: add log
            // TODO: validation
            
            dismiss()
          }
          .buttonStyle(.borderedProminent)
          .tint(.purple)
        }
      }
      .navigationTitle("Add Manual Log")
    .padding()
    }
  }
}

struct AddManualLogSheet_Previews: PreviewProvider {
  static var previews: some View {
    AddManualLogSheet()
  }
}
