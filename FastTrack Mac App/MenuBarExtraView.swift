import SwiftUI

struct MenuBarExtraView: View {
  @Environment(\.managedObjectContext) var moc
  
  @FetchRequest(
    fetchRequest: FastLog.incompleteLogs,
    animation: .default
  )
  private var incompleteLogs: FetchedResults<FastLog>
  
  @State private var isQuittingAppAlertPresented = false
  
  var body: some View {
    content
    .alert("Quit", isPresented: $isQuittingAppAlertPresented) {
      Button("Cancel", role: .cancel, action: {})
      Button("Quit", role: .destructive, action: quitApp)
    } message: {
      Text("Are you sure you want to terminate the app?")
    }
  }
  
  private var content: some View {
    VStack(alignment: .leading) {
      HStack(alignment: .firstTextBaseline) {
        Text("FastTrack")
          .font(.title)
        
        Spacer()

        Button(role: .destructive) {
          isQuittingAppAlertPresented.toggle()
        } label: {
          Label("Quit", systemImage: "xmark.circle.fill")
        }
        .buttonStyle(.borderless)
        .tint(.red)
      }
      
      Divider()
      
      Section {
        if incompleteLogs.isNotEmpty,
           let activeLog = incompleteLogs.first {
          ActiveLogView(log: activeLog)
        } else {
          Text("No active log yet.")
            .foregroundColor(.secondary)
            .padding(.top, 2)
            .padding(.bottom, 5)
        }
      } header: {
        Text("Active Log")
          .font(.headline)
      }
      
      Section {
        if incompleteLogs.isEmpty {
          Button("Start Fasting") {
            _ = FastLog.createPartialLog(using: moc)
          }
        } else {
          Button("Stop Fasting") {
            if let activeLog = incompleteLogs.first {
              FastLog.completePartialLog(for: activeLog, using: moc)
            }
          }
          
          Button("Reset Fasting") {
            if let activeLog = incompleteLogs.first {
              FastLog.resetPartialLog(for: activeLog, using: moc)
            }
          }
        }
      } header: {
        Text("Actions")
          .font(.headline)
      }
      .buttonStyle(.borderless)
      .tint(.purple)
      
      Section {
        Button("Add Manual Log", action: {})
          .buttonStyle(.borderless)
          .tint(.purple)
      } header: {
        Text("More")
          .font(.headline)
      }
    }
    .padding()
  }
}

extension MenuBarExtraView {
  private func quitApp() {
    NSApp.terminate(nil)
  }
}

struct MenuBarExtraView_Previews: PreviewProvider {
  static var previews: some View {
    MenuBarExtraView()
  }
}
