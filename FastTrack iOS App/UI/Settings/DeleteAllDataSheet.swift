//
//  DeleteAllDataSheet.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-11.
//

import SwiftUI

struct DeleteAllDataSheet: View {
  @Environment(\.dismiss) private var dismiss
  
  @State private var sliderValue: Double = .zero
  @State private var isConfirmingDeletion = false
  
  private let maxValue: Double = 100
  let onConfirmDelete: () -> Void
  
  private var isDeleteButtonDisabled: Bool {
    sliderValue < maxValue
  }
  
  var body: some View {
    NavigationStack {
      content
        .navigationTitle("Delete all data")
        .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
            Button(role: .cancel, action: { dismiss() }) {
              Image(systemName: "xmark.circle")
                .font(.title3)
                .tint(.gray)
            }
          }
        }
    }
  }
  
  private var content: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text("Are you sure? This will delete all of your data on all your local devices and remotely in iCloud.")
      
      HStack {
        Image(systemName: "exclamationmark.circle")
          .bold()
          .foregroundColor(.red)
          .imageScale(.large)
        
        Text("You must drag the slider to the end to confirm.")
          .font(.callout)
      }
      .padding(10)
      .background(
        RoundedRectangle(cornerRadius: 10)
          .fill(.red.opacity(0.5))
      )
      .frame(maxWidth: .infinity, alignment: .center)
      
      Slider(value: $sliderValue, in: .zero...maxValue, step: 1)
        .padding(.vertical)
        .animation(.linear, value: sliderValue)
      
      if !isDeleteButtonDisabled {
        Button(role: .destructive, action: deleteAllData) {
          Label("Delete", systemImage: "trash.fill")
            .frame(maxWidth: .infinity)
            .padding(.vertical)
        }
        .buttonStyle(.borderedProminent)
      }
      
      Spacer()
    }
    .padding()
    .animation(.easeInOut, value: isDeleteButtonDisabled)
  }
}

extension DeleteAllDataSheet {
  private func deleteAllData() {
    onConfirmDelete()
    dismiss()
  }
}

struct DeleteAllDataSheet_Previews: PreviewProvider {
  static var previews: some View {
    DeleteAllDataSheet(onConfirmDelete: {})
  }
}
