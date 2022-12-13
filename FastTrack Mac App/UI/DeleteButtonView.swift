//
//  DeleteButtonView.swift
//  FastTrack Mac App
//
//  Created by Zaid Neurothrone on 2022-12-13.
//

import SwiftUI

struct DeleteButtonView: View {
  @Environment(\.managedObjectContext) var moc
  
  @Binding var selectedLog: FastLog?
  
  var body: some View {
    Button(role: .destructive, action: deleteSelected) {
      Label("Delete", systemImage: "trash")
    }
    .keyboardShortcut(.delete, modifiers: [])
    .disabled(selectedLog == nil)
  }
}

extension DeleteButtonView {
  private func deleteSelected() {
    if let selectedLog {
      selectedLog.delete(using: moc)
    }
  }
}
