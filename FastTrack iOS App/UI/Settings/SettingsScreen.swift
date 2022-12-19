//
//  SettingsScreen.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-08.
//

import AppIntents
import SwiftUI

struct SettingsScreen: View {
  @Environment(\.managedObjectContext) private var viewContext
  
  @AppStorage(MyApp.AppStorage.datePickerDisplayMode)
  private var datePickerDisplayMode: DatePickerDisplayMode = .compact
  
  @State private var isAboutSheetPresented = false
  @State private var isDeleteDataSheetPresented = false
  
  var body: some View {
    content
      .sheet(isPresented: $isAboutSheetPresented) {
        AboutSheet()
          .presentationDetents([.fraction(0.25), .medium, .large])
      }
      .sheet(isPresented: $isDeleteDataSheetPresented) {
        DeleteAllDataSheet(onConfirmDelete: deleteAllData)
          .presentationDetents([.fraction(0.5), .medium, .large])
      }
      .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
      .toolbar {
        Menu {
          Button(action: { isAboutSheetPresented.toggle() }) {
            Label("About", systemImage: "info.circle")
          }
        } label: {
          Image(systemName: "ellipsis.circle")
        }
      }
  }
  
  private var content: some View {
    Form {
      Section {
        Picker(selection: $datePickerDisplayMode) {
          ForEach(DatePickerDisplayMode.allCases) { mode in
            Text(mode.rawValue)
              .foregroundColor(.purple)
          }
        } label: {
          Text("Date picker display mode")
            .foregroundColor(.mint)
        }
        .pickerStyle(.menu)
      } header: {
        SectionHeaderView(leftText: "Preferences")
      }
      .listRowBackground(Color.black)
      
      Section {
        ShortcutsLink()
          .shortcutsLinkStyle(.darkOutline)
          .listRowBackground(Color.black)
      } header: {
        SectionHeaderView(leftText: "Productivity")
      }
      
      
      Section {
        Button("Delete all data", role: .destructive) {
          isDeleteDataSheetPresented.toggle()
        }
      } header: {
        SectionHeaderView(leftText: "Data")
      }
      .listRowBackground(Color.black)
      
    }
    .scrollContentBackground(.hidden)
  }
}

extension SettingsScreen {
  private func deleteAllData() {
    FastLog.deleteAll(using: viewContext)
  }
}

struct SettingsScreen_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      SettingsScreen()
        .linearBackground()
        .navigationTitle(Screen.allWeeks.rawValue)
        .navigationBarTitleDisplayMode(.inline)
        .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
    }
  }
}
