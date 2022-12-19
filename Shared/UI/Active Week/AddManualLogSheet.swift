//
//  AddManualLogSheet.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-16.
//

import SwiftUI

struct AddManualLogSheet: View {
  @Environment(\.dismiss) private var dismiss
  @Environment(\.managedObjectContext) private var viewContext
  
  @AppStorage(MyApp.AppStorage.datePickerDisplayMode)
  private var displayMode: DatePickerDisplayMode = .compact
  
  @State private var startedFastingDate: Date = .now
  @State private var stoppedFastingDate: Date = .now
  
  var body: some View {
    NavigationStack {
      content
        .linearBackground()
        .navigationTitle("Add Manual Log")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
            Button("Cancel", role: .cancel, action: { dismiss() })
              .buttonStyle(.borderedProminent)
              .tint(.gray)
          }
          
          ToolbarItem(placement: .navigationBarTrailing) {
            Button("Add", action: addManualLog)
              .buttonStyle(.borderedProminent)
              .disabled(stoppedFastingDate <= startedFastingDate)
          }
        }
    }
  }
  
  private var content: some View {
    Form {
      CustomDatePicker(
        selection: $startedFastingDate,
        label: "Started fasting",
        displayMode: displayMode
      )
      
      CustomDatePicker(
        selection: $stoppedFastingDate,
        label: "Stopped fasting",
        displayMode: displayMode
      )
    }
    .scrollContentBackground(.hidden)
  }
}

extension AddManualLogSheet {
  private func addManualLog() {
    FastLog.createManualLog(
      startedDate: startedFastingDate,
      stoppedDate: stoppedFastingDate,
      using: viewContext
    )
    
    dismiss()
  }
}

struct AddManualLogSheet_Previews: PreviewProvider {
  static var previews: some View {
    AddManualLogSheet()
      .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
  }
}
