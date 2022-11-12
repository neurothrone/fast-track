//
//  SettingsScreen.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-08.
//

import SwiftUI

struct SettingsScreen: View {
  @State private var isAboutSheetPresented = false
  @State private var isDeleteDataSheetPresented = false
  
  var body: some View {
    NavigationStack {
      content
        .linearBackground()
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isAboutSheetPresented) {
          AboutSheet()
            .presentationDetents([.fraction(0.25), .medium, .large])
        }
        .sheet(isPresented: $isDeleteDataSheetPresented) {
          DeleteAllDataSheet(onConfirmDelete: {})
            .presentationDetents([.fraction(0.5), .medium, .large])
        }
        .toolbar {
          Menu {
            Button(action: { isAboutSheetPresented.toggle() }) {
              Label("About", systemImage: "info.circle")
            }
          } label: {
            Image(systemName: "line.3.horizontal")
          }
        }
    }
  }
  
  private var content: some View {
    Form {
      Section {
        
      } header: {
        Text("Preferences")
          .textCase(.none)
      }
      
      Section {
        Button("Delete all data", role: .destructive) {
          isDeleteDataSheetPresented.toggle()
        }
      } header: {
//        SectionHeaderView(leftText: "Data", rightText: "")
        Text("Data")
          .font(.headline)
          .foregroundColor(.secondary)
          .textCase(.none)
      }
      .listRowBackground(Color.black)
      
    }
    .scrollContentBackground(.hidden)
  }
}

struct SettingsScreen_Previews: PreviewProvider {
  static var previews: some View {
    SettingsScreen()
      .preferredColorScheme(.dark)
  }
}
