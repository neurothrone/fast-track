//
//  EditLogSheet.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-12-03.
//

import SwiftUI

struct EditLogSheet: View {
  @Environment(\.dismiss) private var dismiss
  @Environment(\.managedObjectContext) private var viewContext
  
  @AppStorage(Constants.AppStorage.datePickerDisplayMode)
  private var displayMode: DatePickerDisplayMode = .compact
  
  private let log: FastLog
  
  @State private var startedFastingDate: Date = .now
  @State private var stoppedFastingDate: Date = .now
  
  init(log: FastLog) {
    self.log = log
    self.startedFastingDate = log.startedDate
    self.stoppedFastingDate = log.stoppedDate ?? .now
  }
  
  var body: some View {
    NavigationStack {
      Form {
        CustomDatePicker(
          selection: $startedFastingDate,
          label: "Started fasting",
          displayMode: displayMode
        )
        
        if log.stoppedDate != nil {
          CustomDatePicker(
            selection: $stoppedFastingDate,
            label: "Stopped fasting",
            displayMode: displayMode
          )
        }
      }
      .navigationTitle("Add Manual Log")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button("Cancel", role: .cancel, action: { dismiss() })
        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
          Button("Update", action: update)
            .disabled(stoppedFastingDate <= startedFastingDate)
        }
      }
    }
  }
}

extension EditLogSheet {
  private func update() {
    log.startedDate = startedFastingDate
    
    if log.stoppedDate != nil {
      log.stoppedDate = stoppedFastingDate
    }
    
    log.save(using: viewContext)
    
    dismiss()
  }
}

//struct EditLogSheet_Previews: PreviewProvider {
//  static var previews: some View {
//    EditLogSheet()
//  }
//}
