//
//  ActiveWeekScreen.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-08.
//

import SwiftUI

struct ActiveWeekScreen: View {
  var body: some View {
    NavigationStack {
      content
        .linearBackground()
        .navigationTitle("Active Week")
        .navigationBarTitleDisplayMode(.inline)
    }
  }
  
  private var content: some View {
    VStack(alignment: .leading, spacing: .zero) {
      SwipeableLogView()
        .padding([.horizontal, .bottom])
      
      ActiveWeekLogListView()
      
      Spacer()
    }
  }
}

struct ActiveWeekScreen_Previews: PreviewProvider {
  static var previews: some View {
    ActiveWeekScreen()
      .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
//          .preferredColorScheme(.dark)
  }
}
