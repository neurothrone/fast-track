import SwiftUI

struct ContentView: View {
  @AppStorage(MyApp.AppStorage.selectedScreen)
  var selectedScreen: Screen?
  
  var body: some View {
    NavigationSplitView {
      List(selection: $selectedScreen) {
        ForEach(Screen.allForMac) { screen in
          Label(screen.rawValue, systemImage: screen.systemImage)
        }
      }
      .frame(width: 150)
    } detail: {
      if let selectedScreen {
        selectedScreen.screen
      } else {
        Text("Please select something")
      }
    }
    .frame(minWidth: 480, minHeight: 320)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
