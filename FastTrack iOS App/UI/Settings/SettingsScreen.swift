import AppIntents
import SwiftUI

struct SettingsScreen: View {
  @Environment(\.managedObjectContext) private var viewContext
  
  @AppStorage(MyApp.AppStorage.datePickerDisplayMode)
  private var datePickerDisplayMode: DatePickerDisplayMode = .compact
  
  @State private var isAboutSheetPresented = false
  @State private var isDeleteDataSheetPresented = false
  
  @State private var isExporting = false
  @State private var isAlertPresented = false
  @State private var alertTitle = ""
  @State private var alertMessage = ""
  
  var body: some View {
    content
      .alert(
        alertTitle,
        isPresented: $isAlertPresented,
        actions: {
          Button("OK", role: .cancel, action: {})
        }, message: {
          Text(alertMessage)
        }
      )
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
        Button("Export Logs") {
          isExporting.toggle()
        }
        .tint(.purple)
        .fileExporter(
          isPresented: $isExporting,
          document: JSONDocument(
            data: FastLogDTO.from(
              logs: FastLog.getAllLogs(
                using: viewContext
              )
            )
          ),
          contentType: .json,
          defaultFilename: "FastTrack-ExportedData"
        ) { result in
            switch result {
            case .success(_):
              showAlert(
                title: "Export Logs",
                message: "Logs successfully exported."
              )
            case .failure(let error):
              showAlert(
                title: "Export Logs",
                message: "Failed to export logs, error: \(error.localizedDescription)."
              )
            }
          }
        
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
  
  private func showAlert(title: String, message: String) {
    alertTitle = title
    alertMessage = message
    isAlertPresented.toggle()
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
