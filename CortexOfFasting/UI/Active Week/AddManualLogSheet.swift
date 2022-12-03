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
  
  @AppStorage(Constants.AppStorage.weeklyFastingHoursGoal)
  private var weeklyHoursGoal: WeeklyFastingHoursGoal = .easy
  
  @AppStorage(Constants.AppStorage.datePickerDisplayMode)
  private var displayMode: DatePickerDisplayMode = .compact
  
  @State private var startedFastingDate: Date = .now
  @State private var stoppedFastingDate: Date = .now
  
  var body: some View {
    NavigationStack {
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
      .navigationTitle("Add Manual Log")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button("Cancel", role: .cancel, action: { dismiss() })
        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
          Button("Done", action: addManualLog)
            .disabled(stoppedFastingDate <= startedFastingDate)
        }
      }
    }
  }
}

extension AddManualLogSheet {
  private func addManualLog() {
    FastLog.createManualLog(
      startedDate: startedFastingDate,
      stoppedDate: stoppedFastingDate,
      weeklyGoal: weeklyHoursGoal,
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
