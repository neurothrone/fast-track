//
//  FastLogsRowView.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-08.
//

import SwiftUI

struct FastLogsRowView: View {
  @ObservedObject var log: FastLog
  
  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      HStack {
        Text(log.startedDate.inReadableFormat)
        .foregroundColor(.blue)
        
        Spacer()
        
        if log.stoppedDate != nil {
          Text(log.duration.inHoursAndMinutes)
            .font(.callout.bold())
            .foregroundColor(.secondary)
        }
      }
      
      if let stoppedDate = log.stoppedDate {
        Text(stoppedDate.inReadableFormat)
        .foregroundColor(.orange)
      }
    }
  }
}

struct FastLogsRowView_Previews: PreviewProvider {
  static var previews: some View {
    let context = CoreDataProvider.preview.viewContext
    let log = FastLog(context: context)
    log.startedDate = .now.subtracting(minutes: 45)
    log.stoppedDate = .now
    log.save(using: context)
    
    return FastLogsRowView(log: log)
      .environment(\.managedObjectContext, context)
      .padding()
  }
}
